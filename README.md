# MOAP-Docker
## 概要
NEM Catapult テストネットを含めたMOAPシステムをスタンドアロンな状態で構築するためのリポジトリです。

## 構成

以下のアプリケーションが含まれます。

|アプリケーション|説明|
|--|--|
|MOAP-Backend|MOAPのAPIを提供するアプリケーションです|
|MOAP-Front|MOAPのユーザ向けフロントエンドアプリケーションです|
|MOAP-Management|MOAPの店舗向けフロントエンドアプリケーションです|
|MariaDB|MOAP-Backendのストレージとなるデータベースです|
|NEM Catapult Bootstrap|NEM Catapultテストノードを構成するコンテナ群を提供します|
|MOAP-Queue|MOAPの利用データ計測機能を提供します|

## 要求環境

以下のアプリケーション・コマンドがインストールされていること。
- docker(Docker Engine: 19.03.8)
- docker-compose(1.25.5)

|ポート番号|説明|
|:--:|--|
|3000|NEM Catapult APIを提供します|
|9250|MOAP APIを提供します|
|9251|MOAP-Front アプリケーションを提供します|
|9252|MOAP-Management アプリケーションを提供します|
|9253|MOAP-Queue APIを提供します|


## 使用方法

### 初期設定(初回起動)


以下のコマンドを実行し、MOAP-Dockerのダウンロードと初期化を行います。

```
$ git clone https://git.mosin.jp/git/mosin/MOAP-Docker.git
$ cd MOAP-Docker
$ ./cmds/init.sh
``` 

初期化が完了した時点で構成に含まれる各アプリケーションの起動と、MOAPへのNEMの統合(MOAP内の通貨となるMOSAICの発行や、マスタNEMアカウント、店舗用NEMアカウントの発行とMOAP-Backendへの設定)が完了しています。

起動後、最初にMOAP-Managementより商品の追加を行います。
`http://localhost:9252`でMOAP-Management(マネジメント用アプリケーション)にアクセスできます

その後、MOAP-Frontより予め登録しているダミー学籍番号(`1234567890`)を用いてログインします。
`http://localhost:9250`でMOAP-Backend(API)にアクセスできます

**MOAP-FrontとMOAP-ManagementはDockerコンテナ内でDevelop起動されるため、起動直後は数分待つ必要があります。**

その他、以下のアプリケーションを適宜利用できます。
`http://localhost:9251`でMOAP-Front(ユーザー用アプリケーション)にアクセスできます
`http://localhost:9253`でMOAP-Queue(計測API)にアクセスできます

### 終了

MOAPアプリケーションとNEM Catapultを終了します。

```
$ cd MOAP-Docker
$ ./cmds/down.sh
```

### ２回目以降の起動時

MOAPアプリケーションとNEM Catapultを起動します。

```
$ cd MOAP-Docker
$ ./cmds/up.sh
``` 

### DBマイグレーション

MOAP-BackendとMOAP-Queueのmigrationを実行します。

```
# 必要に応じてmigrationファイルを作成します。
$ cd MOAP-Docker/MOAP-Backend
# sequelize コマンドについて詳細はsequelizeのdocsを確認してください
$ sequelize model:create --name test --attributes name:string

# migrationを実行します。
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

