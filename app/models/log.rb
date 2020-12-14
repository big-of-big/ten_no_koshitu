require "open-uri"
require "zlib"

class Log < ApplicationRecord
  validates :name, uniqueness: true
  after_create :pass_log_to_team

  def self.private_room_log(date: Time.current.yesterday)
    file_time_format = date.strftime("%Y%m%d")
    tempfile =
      if date == Time.current.yesterday
        # これは毎日行うrakeタスクでログをダウンロードする場合。
        URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"
      else
        # これはrails db:seedでログをダウンロードする場合。URLは2パターンある。
        begin
          URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"
        rescue
          URI.open "https://tenhou.net/sc/raw/dat/2020/sca#{file_time_format}.log.gz"
        end
      end

    log = ""
    Zlib::GzipReader.open(tempfile) { |gz|
      log = gz.read
    }
    { name: date.strftime("%Y/%m/%d"), content: log }
  end

  # チームメンバー全員の天鳳アカウント名の配列を作る
  def team_members(team)
    return if team.tenhou_accounts.empty?
    tenhou_names = team.tenhou_accounts.map do |tenhou_account|
      tenhou_account.name
    end
    tenhou_names
  end

  # 1つのログから天鳳アカウント名だけ抜き出し配列にする
  def extract_tenhou_accounts_from(game)
    ary = game.split(" ")
    ary.shift(6) # ログから不要な部分(部屋番号や時間など)を削除
    names =
      ary.map do |one_game|
        m = /(?<name>.+)\((?<score>[+-]?[\d\.]+)/.match(one_game)
        m[:name]
      end
    names
  end

  private
    def pass_log_to_team
      # ログを1ゲームごとに分けて配列にする処理
      games = Log.last.content.split("\r\n")

      Team.all.each do |team|
        team_tenhou_accounts = team_members(team)
        # ログのプレーヤー3人もしくは4人が全てが同じチームに所属しているログ
        team_logs =
          games.select do |game|
            (team_tenhou_accounts & extract_tenhou_accounts_from(game)).sort! == extract_tenhou_accounts_from(game).sort!
          end
        unless team_logs.empty?
          TeamLog.create!(name: Log.last.name, content: "#{team_logs}", team_id: team.id)
        end
      end
    end
end
