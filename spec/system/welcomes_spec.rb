require "rails_helper"

RSpec.describe "Welcomes", type: :system do
  context "ユーザーがログインしていない時" do
    it "ログイン前のページが表示される" do
      visit root_path
      expect(page).to have_content "アカウント作成(無料)"
    end
  end
end
