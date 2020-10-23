def private_room_log(date)
  # ログのURLは2パターンある
  file_time_format = date.strftime("%Y%m%d")
  begin
    tempfile = URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"
  rescue
    tempfile = URI.open "https://tenhou.net/sc/raw/dat/2020/sca#{file_time_format}.log.gz"
  end

  log = ""
  Zlib::GzipReader.open(tempfile) {|gz|
    log = gz.read
  }
  {name: date.strftime("%Y/%m/%d"), content: log}
end

if Rails.env == "development"
  Log.create!(private_room_log(Time.new(2020,10,10)))
  Log.create!(private_room_log(Time.new(2020,10,15)))
end
