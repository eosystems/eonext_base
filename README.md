# 環境構築
## Docker Desktop インストール
https://hub.docker.com/editions/community/docker-ce-desktop-mac

## リポジトリダウンロード
git clone https://github.com/eosystems/eonext_base

## DB設定
cp config/database.yml.example config/database.yml

## eonext_baseに移動後にRails, DBの構築
```
docker-compose build
docker-compose run api bundle exec rake db:create
docker-compose run api bundle exec rake db:migrate
```

## 起動
```
docker-compose up -d
```

localhost:3001 に接続できること

## コンソール
```
docker-compose run api bundle exec rails console
User.count
```

## DB確認
Sequel Pro インストール
![image](https://user-images.githubusercontent.com/3175028/54863435-eb995c00-4d8b-11e9-932a-b39436da25b3.png)
