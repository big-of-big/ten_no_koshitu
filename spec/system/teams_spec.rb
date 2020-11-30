require "rails_helper"

RSpec.describe "Teams", type: :system do
  let(:team_1) { Team.create!(id: 1, name: "ぴよぴよ麻雀部", join_key: "35232") }
  let(:team_2) { Team.create!(id: 2, name: "つよつよ麻雀部", join_key: "52423") }
  let(:user) { User.create!(name: "komugi", password: "password", team_id: team_1.id) }

  before do
    login_as user
  end

  context "自分のチームの場合" do
    it "チーム名を変更できる" do
      visit edit_team_path(user.team)
      fill_in "チーム名", with: "プロを目指す麻雀部"
      click_button "更新"
      expect(page).to have_content "チーム情報を更新しました。"
    end
  end

  context "自分のチームではない場合" do
    it "編集画面に行くことはできない" do
      visit edit_team_path(team_2)
      expect(page).to have_content "権限がありません。"
    end
  end
end
