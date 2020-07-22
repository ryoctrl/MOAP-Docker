#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

cd $SCRIPT_DIR/../

echo "MOAPシステムをダウンロードしています"

git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
git clone https://git.mosin.jp/git/mosin/MOAP-Front.git
git clone https://git.mosin.jp/git/mosin/MOAP-Management.git
git clone https://git.mosin.jp/git/mosin/Queue-Backend.git MOAP-Queue
#git clone https://github.com/tech-bureau/catapult-service-bootstrap.git catapult -b 0.8.0.3
git clone https://github.com/tech-bureau/catapult-service-bootstrap.git catapult -b 0.9.6.3-beta1

echo "NEM Catapultを初期化しています"
$SCRIPT_DIR/catapult-up.sh

echo "{}" > symbol-cli.config.json

ADDRESSES_PATH=$SCRIPT_DIR/../catapult/build/generated-addresses/addresses.yaml

curl -s -X GET http://localhost:3000/blocks/1 > /dev/null

echo "NEM Catapultの起動を待機しています"
while [ $? != 0 ]
do
    sleep 0.5
    curl -s -X GET http://localhost:3000/blocks/1 > /dev/null
done
echo "NEM Catapultが起動しました"

sleep 5

echo "NEM2-CLIを初期化しています"

docker build -t symbol-cli ./build/symbol-cli

sleep 10
MASTER_PRIV=$(cat $ADDRESSES_PATH | ./cmds/yq.sh r - 'nemesis_addresses[0].private')
SYMBOL_PWD=11111111
SYMBOL_HOST=http://host.docker.internal:3000

$SCRIPT_DIR/symbol-cli profile import -p $SYMBOL_PWD -n TEST_NET -P $MASTER_PRIV -u $SYMBOL_HOST --profile master -d

MOSAIC_ID=$($SCRIPT_DIR/symbol-cli transaction mosaic --profile master -p $SYMBOL_PWD --non-expiring --divisibility 0 --restrictable --supply-mutable --transferable --amount 10000000 --max-fee 0 --announce -M normal | grep Mosaic | head -1 | awk '{print $10}')


echo "MOSAICを発行しました. MOSAIC_ID: $MOSAIC_ID"

echo "MOAPシステムを初期化しています"
touch .env
docker-compose -f docker-compose-init.yml up

echo "MOSAIC=$MOSAIC_ID" >> .env

echo "MOAPシステムを起動しています"
$SCRIPT_DIR/up.sh

# 初回起動時に非同期にDBの初期化が行われるため、しばらく待ってからmigrationを実行する
echo "MOAPシステムを起動しました."
echo "データベースの初期化を待機しています."
sleep 30
$SCRIPT_DIR/migrate.sh

echo "データベースを初期化しました."

echo "テストユーザを登録します."
ID=1234567890
$SCRIPT_DIR/register_user.sh $ID
echo "学籍番号 $ID をテストユーザとして登録しました。"

echo "http://localhost:9251/ からMOAP-Frontにアクセスできます。(初回起動時は数分待つ必要があります)"
echo "http://localhost:9252/ からMOAP-Managementにアクセスできます。"
echo "http://localhost:9250/ からMOAP-Backend(API)にアクセスできます。"
echo "./cmds/logs.sh を実行することでMOAPの各アプリケーションが出力するログを確認できます。"
echo "cd ./catapult/cmds/docker && docker-compose logs -f を実行することでNEMの各アプリケーションが出力するログを確認できます"
