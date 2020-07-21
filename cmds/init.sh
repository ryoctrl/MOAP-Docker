#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

cd $SCRIPT_DIR/../

echo "MOAPシステムをダウンロードしています"

git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
git clone https://git.mosin.jp/git/mosin/MOAP-Front.git
git clone https://git.mosin.jp/git/mosin/MOAP-Management.git
git clone https://github.com/tech-bureau/catapult-service-bootstrap.git catapult

echo "NEM Catapultを初期化しています"
$SCRIPT_DIR/catapult-up.sh

ADDRESSES_PATH=$SCRIPT_DIR/../catapult/build/generated-addresses/addresses.yaml

while [ ! -e $ADDRESSES_PATH ]
do
    sleep 0.5
done

echo "MOAPシステムを初期化しています"
docker-compose -f docker-compose-init.yml up

echo "MOAPシステムを起動しています"
$SCRIPT_DIR/up.sh

# 初回起動時に非同期にDBの初期化が行われるため、しばらく待ってからmigrationを実行する
echo "MOAPシステムを起動しました."
echo "データベースの初期化を待機しています."
sleep 30
$SCRIPT_DIR/migrate.sh

echo "データベースを初期化しました."

$SCRIPT_DIR/logs.sh

