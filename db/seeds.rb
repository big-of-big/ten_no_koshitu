# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def private_room_log(date)
  file_time_format = date.strftime("%Y%m%d")
  yesterday_log = URI.open "https://tenhou.net/sc/raw/dat/sca#{file_time_format}.log.gz"

  log = ""
  Zlib::GzipReader.open(yesterday_log) {|gz|
    log = gz.read
  }
  {name: file_time_format, content: log}
end

if Rails.env == "development"
  # Log.create!(private_room_log(Time.new(2020,10,10)))
  Log.create!(private_room_log(Time.new(2020,10,15)))
end
