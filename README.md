# MOAP-Docker
## Description
NEM Catapult テストネットを含めたMOAPシステムをスタンドアロンな状態で構築するためのリポジトリです。
初回起動時に`cmds/init.sh`を実行することで


## Plan
- MOAP-Backend

- MOAP-Front

- MOAP-Management

- MariaDB
    - [DockerHub](https://hub.docker.com/_/mariadb)

- NEM Catapult Node

## Usage

### 初回起動時
```
$ git clone https://git.mosin.jp/git/mosin/MOAP-Docker.git
$ cd MOAP-Docker

# 初期化
$ ./cmds/init.sh

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
$ ./cmds/down.sh
```

### ２回目以降の起動時

```
$ cd MOAP-Docker
$ ./cmds/up.sh
``` 

### DBマイグレーション

```
$ cd MOAP-Docker/MOAP-Backend
# sequelize コマンドについて詳細はsequelizeのdocsを確認してください
$ sequelize model:create --name test --attributes name:string

$ cd ..
$ ./migrate.sh
```

### テストユーザ追加
`register_user.sh`の引数に学籍番号(10桁)を渡すことで登録できます。
この時、MOAPシステムのMOAP-Backendが起動している必要があります。

```
$ cd /path/to/MOAP-Docker
$ ./cmds/register_user.sh 1234567890
```

### nem操作
`nem2-cli.sh`を使用することで、nem2-cliを利用することができます。
詳細はhelpを確認してください。

```
$ cd /path/to/MOAP-Docker
$ ./cmds/nem2-cli.sh -h
```
