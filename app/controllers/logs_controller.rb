require 'open-uri'

class LogsController < ApplicationController
  def index
    date_lists_text = URI.open "https://tenhou.net/sc/raw/list.cgi#"
    @log = date_lists_text.read

    File.open("file_name_lists.txt","w") do |f|
      f.puts @log
    end
  end
end
