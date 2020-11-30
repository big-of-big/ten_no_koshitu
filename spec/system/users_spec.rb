require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # before do
  #   @user = User.create!(name: 'komugi', password: "password")
  # end

  it "ユーザーが新規登録できる" do
    visit signup_path

    fill_in "ユーザー名(ログインに使用します)", with: "komugi"
    fill_in "パスワード(6文字以上)", with: "password"
    fill_in "パスワード(確認)", with: "password"

    # 更新実行
    click_button "ユーザー登録"

    # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
    expect(page).to have_content "アカウント登録が完了しました。"
  end
end
