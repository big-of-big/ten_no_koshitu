require "rails_helper"

RSpec.describe "Teams", type: :system do
  let(:team_1) { Team.create!(id: 1, name: "ぴよぴよ麻雀部", join_key: "35232") }
  let(:team_2) { Team.create!(id: 2, name: "つよつよ麻雀部", join_key: "52423") }
  let(:user_1) { User.create!(name: "komugi", password: "password", team_id: team_1.id) }
  let(:user_2) { User.create!(name: "rinrin", password: "password") }

  context "自分のチームの場合" do
    it "チーム名を変更できる" do
      login_as user_1
      visit edit_team_path(user_1.team)
      fill_in "チーム名", with: "プロを目指す麻雀部"
      click_button "更新"
      expect(page).to have_content "チーム情報を更新しました。"
    end
  end

  context "自分のチームではない場合" do
    it "編集画面に行くことはできない" do
      login_as user_1
      visit edit_team_path(team_2)
      expect(page).to have_content "権限がありません。"
    end
  end

  context "チームに参加していない場合" do
    it "チームを作成できる" do
      login_as user_2
      visit new_team_path
      fill_in "チーム名", with: "プロを目指す麻雀部"
      click_button "新規作成"
      expect(page).to have_content "チームを作成しました。"
    end

    it "チームに参加できる" do
      login_as user_2
      visit teams_join_path
      fill_in "チームID", with: team_2.join_key
      click_button "参加"
      expect(page).to have_content "チームに参加しました。"
    end
  end
end
