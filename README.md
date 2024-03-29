# 天の個室
![image](https://user-images.githubusercontent.com/60137763/119219440-951d3900-bb20-11eb-861f-bfadab02d765.png)

天の個室は、天鳳個室の成績を手動で入力するのが億劫だという問題を解決したい、
競技麻雀部向けの成績管理システムです。
ユーザーは自分やチームメイトの成績を見ることができ、
エクセルとは違って手動で成績を入力する必要がないことが特徴です。

## 使用技術
- Ruby
- Ruby on Rails
- JavaScript
- Vue.js
- Slim
- SCSS
- Bootstrap
- PostgreSQL
- RSpec
- RuboCop
- ESLint
- Slim-Lint
- Heroku

## インストール

開発環境ではSQLite3を使用しています。
SQLite3では`$bin/setup`でseedが入らないので`$ rails db:seed`を実行してください。
```
$ bin/setup
$ rails db:seed
$ rails server
```

以下の情報でログインください。
```
ユーザー名: komugi
パスワード: password
```

## Lint
rubocop,slim-lint,eslintを実行します。
```
$ bin/lint
```

## テスト
```
$ bundle exec rspec
```
