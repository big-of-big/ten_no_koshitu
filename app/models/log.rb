require 'open-uri'
require 'zlib'

class Log < ApplicationRecord
  validates :name, uniqueness: true

  def self.private_room_log
    yesterday = Time.current.yesterday
    file_time_format = yesterday.strftime("%Y%m%d")
    yesterday_log = URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"

    log = ""
    Zlib::GzipReader.open(yesterday_log) {|gz|
      log = gz.read
    }

    {name: file_time_format, content: log}
  end
end
