# MOAP-Docker
## Description
NEM Catapult テストネットを含めたMOAPシステムをスタンドアロンな状態で構築するためのリポジトリです。
初回起動時に`cmds/init.sh`を実行することでMOAP-Backend, MOAP-Front, MOAP-Management, Nem Catapult Bootstrapを起動し、MOSAIC作成やNEMアカウントのMOAPへの統合を行います。

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

# http://localhost:9250でMOAP-Backend(API)にアクセスできます
# http://localhost:9251でMOAP-Front(ユーザー用アプリケーション)にアクセスできます
# http://localhost:9252でMOAP-Management(マネジメント用アプリケーション)にアクセスできます

# MOAP-FrontとMOAP-ManagementはDockerコンテナ内でDevelop起動されるため、起動直後は数分待つ必要があります。

# MOAPを起動後、MOAP-Managementにアクセスし、新規商品を追加します。
open http://localhost:9252

# 商品を追加後、MOAP-Frontにアクセスし、MOAPを使用します。
open http://localhost:9251
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

## 構成

