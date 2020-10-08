require 'open-uri'
require 'zlib'

class LogsController < ApplicationController
  def index
    yesterday = Time.current.yesterday
    file_time_format = yesterday.strftime("%Y%m%d")
    yesterday_log = URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"

    Zlib::GzipReader.open(yesterday_log) {|gz|
      @log = gz.read
    }
  end
end
