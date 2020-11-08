require 'open-uri'
require 'zlib'

class Log < ApplicationRecord
  include LogsHelper
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
    Zlib::GzipReader.open(tempfile) {|gz|
      log = gz.read
    }
    { name: date.strftime("%Y/%m/%d"), content: log }
  end

  private
    def pass_log_to_team
      # ログを1ゲームごとに分けて配列にする処理
      games = Log.last.content.split("\r\n")

      Team.all.each do |team|
        team_tenhou_accounts = team_members(team)
        # ログの中からチームメンバー全ての名前があるログのみを取得する
        team_logs =
          games.select do |game|
            (team_tenhou_accounts & extract_tenhou_accounts_from(game)).sort! == extract_tenhou_accounts_from(game).sort!
          end
        unless team_logs.empty?
          TeamLog.create!(name:Log.last.name, content:"#{team_logs}",team_id: team.id )
        end
      end
    end
end
