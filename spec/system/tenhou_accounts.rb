require "rails_helper"

RSpec.describe "TenhouAccounts", type: :system do
  let(:team_1) { Team.create!(id: 1, name: "ぴよぴよ麻雀部", join_key: "35232") }
  let(:team_2) { Team.create!(id: 2, name: "つよつよ麻雀部", join_key: "52423") }
  let(:user) { User.create!(name: "komugi", password: "password", team_id: team_1.id) }
  let(:tenhou_1) { TenhouAccount.create!(name: "こむぎ", team_id: team_1.id) }

  before do
    login_as user
  end

  context "入力値が正常な場合" do
    it "天鳳アカウントを追加できる" do
      visit new_tenhou_account_path
      fill_in "天鳳アカウント名", with: "りんりん"
      click_button "追加"
      expect(page).to have_content "チームにメンバーを追加しました。"
    end

    it "天鳳アカウント名を変更できる" do
      visit edit_tenhou_account_path(tenhou_1)
      fill_in "天鳳アカウント名", with: "りんりん"
      click_button "保存"
      expect(page).to have_content "天鳳アカウントを変更しました。"
    end

    it "天鳳アカウントを削除できる" do
      visit edit_tenhou_account_path(tenhou_1)
      page.accept_confirm do
        click_link "削除"
      end
      expect(page).to have_content "メンバーを削除しました。"
    end
  end

  context "入力値が異常な場合" do
    it "天鳳アカウント名に禁止文字が含まれている" do
      visit edit_tenhou_account_path(tenhou_1)
      fill_in "天鳳アカウント名", with: "り んりん"
      click_button "保存"
      expect(page).to have_content "天鳳アカウント名に使用できない文字が含まれています"
    end

    it "天鳳アカウント名が9文字以上である" do
      visit edit_tenhou_account_path(tenhou_1)
      fill_in "天鳳アカウント名", with: "長すぎるおなまえだよ"
      click_button "保存"
      expect(page).to have_content "天鳳アカウント名は8文字以内で入力してください"
    end
  end
end
