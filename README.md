# README
## 概要
DockerでRails with MySQLを使うためのテンプレートです。

## バージョン
- Ruby: 3.2.2
- Rails: 6.1.7.X
- MySQL: 8.0.35

## 動作
- `docker compose build`でコンテナをビルドできます
- `docker compose run --rm app rails new . --force --database=mysql --skip-bundle`でアプリのファイル群を作ることができます

## バージョンを変える
- Rubyのバージョンを変えるときは、Dockerfileの`FROM`を変更します
- Railsのバージョンを変えるときは、Gemfileの`gem 'rails'`の記述を変更します
- MySQLのバージョンを変えるときは、docker-compose.ymlの`db:image`を変更します
