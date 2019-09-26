# MOAP-Docker
## Description
MOAPシステムをスタンドアロンな状態で構築するためのオールインワンなリポジトリ

## Plan
- MOAP-Backend
- MOAP-Front
- MOAP-Management
- MariaDB
    - [DockerHub](https://hub.docker.com/_/mariadb)

- NEM Catapult Node(未搭載)

## Usage

### 初回起動時
```
# 当リポジトリをclone
$ git clone https://git.mosin.jp/git/mosin/MOAP-Docker.git
$ cd MOAP-Docker

# 初期化
$ ./init.sh

# ログが流れ続けるのでCtrl-Cで終了できます。
# http://localhost:9250/でBackendにアクセスできます
$ curl http://localhost:9250/ 

# http://localhost:9251/でユーザー用アプリケーションにアクセスできます
$ curl http://localhost:9251/

# http://localhost:9252/でマネジメント用アプリケーションにアクセスできます
$ curl http://localhost:9252/
```

### 終了

```
$ cd MOAP-Docker
$ ./down.sh
```

### ２回目以降の起動時

```
$ cd MOAP-Docker
$ ./up.sh
``` 

### DBマイグレーション

```
$ cd MOAP-Docker/MOAP-Backend
# sequelize コマンドについて詳細はsequelizeのdocsを確認してください
$ sequelize model:create --name test --attributes name:string

$ cd ..
$ ./migrate.sh
```

