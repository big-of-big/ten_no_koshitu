class User < ApplicationRecord
  belongs_to :team, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
  def games
    text_content = Log.first.content
    text_content.split("\r\n")
  end

  # 自分が打った試合のみの配列を返す
  def my_games
    games.select do |game|
      game.include?(self.tenhou_account)
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

