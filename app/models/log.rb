require 'open-uri'
require 'zlib'

class Log < ApplicationRecord
  validates :name, uniqueness: true
  after_create :pass_log_to_team


  def self.private_room_log
    yesterday = Time.current.yesterday
    file_time_format = yesterday.strftime("%Y%m%d")
    yesterday_log = URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"

    log = ""
    Zlib::GzipReader.open(yesterday_log) {|gz|
      log = gz.read
    }

    {name: yesterday.strftime("%Y/%m/%d"), content: log}
  end

  private
    def pass_log_to_team
      # ログを1ゲームごとに分けて配列にする処理
      # プレーヤー名に"\r\n"が含まれていてもエスケープしてくれる
      games = Log.last.content.split("\r\n")

      Team.all.each do |team|
        team_tenhou_accounts = team_members(team)
        team_logs =
          games.select do |game|
            (team_tenhou_accounts & extract_tenhou_accounts_from(game)).sort! == extract_tenhou_accounts_from(game).sort!
            end
        unless team_logs.empty?
          TeamLog.create!(name:Log.last.name, content:"#{team_logs}",team_id: team.id )
        end
      end
    end

  # チームメンバー全員の名前の配列を作る
  def team_members(team)
    return if team.tenhou_accounts.empty?
    hoge = team.tenhou_accounts.map do |tenhou_account|
        tenhou_account.name
      end
    hoge
  end

  # 1つのログから天鳳アカウント名だけ抜き出し配列にする
  def extract_tenhou_accounts_from(game)
    ary = game.split(" ")
    ary.shift(6) # ログから不要な部分を削除
    names =
      ary.map do |game|
        # 天鳳アカウント名に()を含むことはできない
        m = /(?<name>.+)\(/.match(game)
        m[:name]
      end
    names
  end

  # 自分が打った試合の配列を返す
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
