require 'open-uri'
require 'zlib'

class Log < ApplicationRecord
  include LogsHelper

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
