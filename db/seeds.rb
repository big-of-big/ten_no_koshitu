def user_seed(name)
  {
    name: name,
    password: "password",
    team_id: 1
  }
end

names = ["こむぎ", "夜叉丸", "グランドクロス", "麻雀たろう", "v-bind"]

if Rails.env == "development"
  Team.create!(id: 1, name: "フルスタック麻雀部", join_key: 34323)
  User.create!(user_seed("komugi"))
  User.create!(user_seed("yasyamaru"))
  names.each do |name|
    TenhouAccount.create!(name: name, team_id: 1)
  end

  start = Date.new(2020, 5)
  last = Date.new(2020, 11)
  (start..last).each do |date|
  TeamLog.create!(
     name: date.strftime("%Y/%m/%d"),
     team_id: 1,
     content: "[\"L1412 | 18:25 | 三般東喰赤－ | 夜叉丸(+46.0) こむぎ(-7.0) v-bind(-39.0)\", \"L1412 | 18:33 | 四般東喰赤－ | 夜叉丸(+40.0) v-bind(+5.0) こむぎ(-15.0) グランドクロス(-30.0)\", \"L1412 | 18:44 | 三般東喰赤－ | 夜叉丸(+69.0) こむぎ(-18.0) グランドクロス(-51.0)\"]"
  )
  end
end
