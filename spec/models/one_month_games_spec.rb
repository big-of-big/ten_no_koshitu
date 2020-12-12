require "rails_helper"

RSpec.describe OneMonthGames, type: :model do
  describe ".make_one_month_games_objects" do
    let!(:team) { create(:team) }
    let!(:team_log) { create(:team_log) }
    let!(:komugi) { create(:komugi) }

    it "TenhouAccountオブジェクトが打った全てのOneMonthGameオブジェクトを取得できる" do
      one_game_objects = [
        OneGame.new("2020/11/15", "L1412 | 18:25 | 三般東喰赤－ | 夜叉丸(+46.0) こむぎ(-7.0) v-bind(-39.0)"),
        OneGame.new("2020/11/15", "L1412 | 18:33 | 四般東喰赤－ | 夜叉丸(+40.0) v-bind(+5.0) こむぎ(-35.0) グランドクロス(-30.0)"),
        OneGame.new("2020/12/16", "L1412 | 18:44 | 三般東喰赤－ | 夜叉丸(+69.0) こむぎ(-18.0) グランドクロス(-51.0)")
      ]
      expect(OneMonthGames.make_one_month_games_objects(one_game_objects).class).to eq Array
      expect(OneMonthGames.make_one_month_games_objects(one_game_objects).count).to eq 2
      expect(OneMonthGames.make_one_month_games_objects(one_game_objects)[0].name).to eq "2020/11"
      expect(OneMonthGames.make_one_month_games_objects(one_game_objects)[1].name).to eq "2020/12"
      expect(
        OneMonthGames .make_one_month_games_objects(one_game_objects)[1]
          .three_games[0]
          .one_game_log
      ).to eq  "L1412 | 18:44 | 三般東喰赤－ | 夜叉丸(+69.0) こむぎ(-18.0) グランドクロス(-51.0)"
    end
  end
end
