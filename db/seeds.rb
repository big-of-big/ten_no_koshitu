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
  Team.create!(id: 1, name: "フルスタック麻雀部", join_key: 34323)
  User.create!(user_seed("komugi"))
  User.create!(user_seed("yasyamaru"))
  names.each do |name|
    TenhouAccount.create!(name: name, team_id: 1)
  end
  Log.create!(Log.private_room_log(date: Time.new(2020,11,7)))
end
