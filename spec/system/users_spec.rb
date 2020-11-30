require "rails_helper"

RSpec.describe "Users", type: :system do
  it "ユーザーが新規登録できる" do
    visit signup_path

    fill_in "ユーザー名(ログインに使用します)", with: "komugi"
    fill_in "パスワード(6文字以上)", with: "password"
    fill_in "パスワード(確認)", with: "password"
    click_button "ユーザー登録"

    expect(page).to have_content "アカウント登録が完了しました。"
  end

  it "同じ名前のユーザーは登録できない" do
    User.create!(name: "komugi", password: "password")

    visit signup_path

    fill_in "ユーザー名(ログインに使用します)", with: "komugi"
    fill_in "パスワード(6文字以上)", with: "password"
    fill_in "パスワード(確認)", with: "password"
    click_button "ユーザー登録"

    expect(page).to have_content "ユーザー名はすでに存在します"
  end

  it "パスワードは6文字以下だと登録できない" do
    visit signup_path

    fill_in "ユーザー名(ログインに使用します)", with: "komugi"
    fill_in "パスワード(6文字以上)", with: "pass"
    fill_in "パスワード(確認)", with: "pass"
    click_button "ユーザー登録"

    expect(page).to have_content "パスワードは6文字以上で入力してください"
  end

  it "パスワードが違うと登録できない" do
    visit signup_path

    fill_in "ユーザー名(ログインに使用します)", with: "komugi"
    fill_in "パスワード(6文字以上)", with: "password"
    fill_in "パスワード(確認)", with: "hogehoge"
    click_button "ユーザー登録"

    expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
  end

  it "正しい情報でログインできる" do
    User.create!(name: "komugi", password: "password")

    visit login_path

    fill_in "ユーザー名", with: "komugi"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
  end

  it "間違った情報ではログインできる" do
    User.create!(name: "komugi", password: "password")

    visit login_path

    fill_in "ユーザー名", with: "komugi"
    fill_in "パスワード", with: "incorrect_password"
    click_button "ログイン"

    expect(page).to have_content "ユーザー名またはパスワードが違います。"
  end
end
