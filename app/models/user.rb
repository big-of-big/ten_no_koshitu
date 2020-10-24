class User < ApplicationRecord
  belongs_to :team, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true

  validates :tenhou_account,
    presence: true,
    length: { maximum: 8 },
    uniqueness: { scope: :team_id }
  validate :correct_tenhou_account

  def correct_tenhou_account
    if [" ", "　", "(" ,")", "（" ,"）"].any? { |i| tenhou_account.include?(i) }
      errors.add(:tenhou_account, "に使用できない文字が含まれています")
    end
  end
  # deviseのメソッドをオーバーライドして、パスワード無しでユーザー情報を編集できるようにする
  def update_with_password(params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update(params)
    clean_up_passwords
    result
  end

  # ログを1ゲームごとに分けて配列にする処理
  # プレーヤー名に"\r\n"が含まれていてもエスケープしてくれる
  # ["L6660 | 15:41 | 四般南喰－－ | i505(+108.0) natscame(-11.0) ホップステップ(-43.0) COO007(-54.0)",
  #  "L6789 | 14:33 | 三般南喰赤－ | エト:オルタ(+50.0) nica*゜(+4.0) -Archer-(-54.0)",
  #  "L6789 | 14:51 | 三般南喰赤－ | nica*゜(+66.0) エト:オルタ(-11.0) -Archer-(-55.0)"]
  def games
    text_content = Log.first.content
    text_content.split("\r\n")
  end

  def extract_tenhou_accounts_from(game)
    ary = game.split(" ")
    ary.shift(6) # ログから不要な部分(部屋番号や時間など)を削除
    names =
      ary.map do |game|
        # 天鳳アカウント名に()を含むことはできない
        m = /(?<name>.+)\(/.match(game)
        m[:name]
      end
    names
  end

  # 自分が打った試合のみの配列を返す
  def my_games
    # game => "L6660 | 09:36 | 四般南喰－－ | COO007(+64.0) natscame(+4.0) i505(-25.0) ホップステップ(-43.0)"
    games.select do |game|
      # ["hoge","guga","huba"]
      tenhou_accounts_names = extract_tenhou_accounts_from(game)
      tenhou_accounts_names.include?(self.tenhou_account)
    end
  end

  # 4・3人打ち合算の得点を出す
  def make_score_array
    # 自分の得点の配列を作る
    scores =
      my_games.map do |my_game|
        m = /#{tenhou_account}\((?<score>.+?)\)/.match(my_game)
        m[:score].to_i
      end
    scores
  end

  def display_score
    total_score = make_score_array.sum
    total_score >= 0 ? "+#{total_score}" : total_score
  end

  def total_game_count
    make_score_array.count
  end
end

