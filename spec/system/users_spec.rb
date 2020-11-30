require "rails_helper"

RSpec.describe "Users", type: :system do
  let(:team) { Team.create!(id: 1, name: "ぴよぴよ麻雀部", join_key: "35232") }
  let(:user) { User.create!(name: "komugi", password: "password", team_id: team.id) }

  before do
    login_as user
  end

  context "入力値が正常な場合" do
    it "ユーザー名を変更できる" do
      visit edit_user_registration_path(user)
      fill_in "ユーザー名", with: "changed_name"
      click_button "保存"
      expect(page).to have_content "アカウント情報を変更しました。"
    end

    it "パスワードを変更できる" do
      visit edit_user_registration_path(user)
      fill_in "新しいパスワード(6文字以上)", with: "new_password"
      fill_in "パスワード(確認)", with: "new_password"
      click_button "保存"
      expect(page).to have_content "アカウント情報を変更しました。"
    end

    it "アカウントを削除できる" do
      visit edit_user_registration_path(user)
      page.accept_confirm do
        click_link "アカウント削除"
      end
      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
    end
  end

  context "入力値が異常な場合" do
    it "パスワードが一致していない" do
      visit edit_user_registration_path(user)
      fill_in "新しいパスワード(6文字以上)", with: "new_password"
      fill_in "パスワード(確認)", with: "incorrect_password"
      click_button "保存"
      expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
    end

    it "パスワードが6文字未満である" do
      visit edit_user_registration_path(user)
      fill_in "新しいパスワード(6文字以上)", with: "pass"
      fill_in "パスワード(確認)", with: "pass"
      click_button "保存"
      expect(page).to have_content "パスワードは6文字以上で入力してください"
    end
  end

  context "ユーザーがチームに所属している場合" do
    it "チームから脱退できる" do
      visit edit_user_registration_path(user)
      click_link "チームから脱退する"
      expect(page).to have_content "チームから脱退しました"
    end
  end
end
