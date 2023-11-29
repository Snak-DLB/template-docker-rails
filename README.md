# README
## 概要
DockerでRails with MySQLを使うためのテンプレートです。

## バージョン
- Ruby: 3.2.2
- Rails: 6.1.7.X
- MySQL: 8.0.35

## コンテナの起動まで
1. `docker compose build`でコンテナをビルドします
1. `docker compose run --rm app rails new . --force --database=mysql`でアプリのファイル群を作ります（READMEの内容が書き換わるので注意してください）
1. config/database.ymlの`default: &default`内の`host`を`host: db`と書き換えてください
1. `docker compose run --rm app rails db:create`でデータベースを作成します
1. `docker compose up`で起動します
1. `localhost:8000`で画面を確認できます

## バージョンを変える
- Rubyのバージョンを変えるときは、Dockerfileの`FROM`を変更します
- Railsのバージョンを変えるときは、Gemfileの`gem 'rails'`の記述を変更します
- MySQLのバージョンを変えるときは、docker-compose.ymlの`db:image`を変更します
