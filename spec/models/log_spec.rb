require "rails_helper"

RSpec.describe Log, type: :model do
  describe "#team_members" do
    let!(:team) { create(:team) }
    let!(:komugi) { create(:komugi) }
    let!(:yasyamaru) { create(:yasyamaru) }
    let!(:v_bind) { create(:v_bind) }
    let!(:grandcross) { create(:grandcross) }

    it "チームメンバー全員の天鳳アカウント名の配列を作ることができる" do
      log = Log.new
      expect(log.team_members(team)).to eq ["こむぎ", "夜叉丸", "v-bind", "グランドクロス"]
    end
  end

  describe "#extract_tenhou_accounts_from" do
    it "1つのログから天鳳アカウント名だけ抜き出し配列にすることができる" do
      log = Log.new
      game = "L1412 | 18:25 | 三般東喰赤－ | 夜叉丸(+46.0) こむぎ(-7.0) v-bind(-39.0)"
      expect(log.extract_tenhou_accounts_from(game)).to eq ["夜叉丸", "こむぎ", "v-bind"]
    end
  end
end
