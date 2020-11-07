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
  { name: date.strftime("%Y/%m/%d"), content: log }
end

def user_seed(name)
  {
    name: name,
    email: "#{name}@example.com",
    password: "password",
    team_id: 1
  }
end

names = ["こむぎ","夜叉丸","グランドクロス","麻雀たろう","v-bind"]

if Rails.env == "development"
  Team.create!(id: 1, name: "バックエンド麻雀部", join_key: 34323)
  User.create!(user_seed("komugi"))
  User.create!(user_seed("yasyamaru"))
  names.each do |name|
    TenhouAccount.create!(name: name, team_id: 1)
  end

  # Log.create!(private_room_log(Time.new(2020,10,10)))
  # Log.create!(private_room_log(Time.new(2020,10,15)))
end
