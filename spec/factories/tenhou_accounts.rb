FactoryBot.define do
  factory :komugi, class: "TenhouAccount" do
    name { "こむぎ" }
    team_id { 1 }
  end
end

FactoryBot.define do
  factory :yasyamaru, class: "TenhouAccount" do
    name { "夜叉丸" }
    team_id { 1 }
  end
end

FactoryBot.define do
  factory :v_bind, class: "TenhouAccount" do
    name { "v-bind" }
    team_id { 1 }
  end
end

FactoryBot.define do
  factory :grandcross, class: "TenhouAccount" do
    name { "グランドクロス" }
    team_id { 1 }
  end
end
