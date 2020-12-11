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
end
