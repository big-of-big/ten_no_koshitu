require "rails_helper"

RSpec.describe OneGame, type: :model do
  describe "#game_type_of" do
    it "1行のログが3人打ちか4人打ちかを判断できる" do
      game_log = "L1412 | 18:25 | 三般東喰赤－ | 夜叉丸(+46.0) こむぎ(-7.0) v-bind(-39.0)"
      one_game = OneGame.new("2020/11/25", game_log)
      expect(one_game.game_type_of(game_log)).to eq 3
    end
  end

  describe ".one_game_objects_of" do
    let!(:team) { create(:team) }
    let!(:team_log) { create(:team_log) }
    let!(:komugi) { create(:komugi) }

    it "TenhouAccountオブジェクトが打った全てのOneGameオブジェクトを取得できる" do
      expect(OneGame.one_game_objects_of(komugi).class).to eq Array
      expect(OneGame.one_game_objects_of(komugi).count).to eq 3
      expect(OneGame.one_game_objects_of(komugi)[0].name).to eq "2020/12/10"
      expect(OneGame.one_game_objects_of(komugi)[0].one_game_log).to eq "L1412 | 18:25 | 三般東喰赤－ | 夜叉丸(+46.0) こむぎ(-7.0) v-bind(-39.0)"
    end
  end
end
