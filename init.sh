#!/bin/bash

git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
git clone -b develop https://git.mosin.jp/git/mosin/MOAP-Front.git 
git clone https://git.mosin.jp/git/mosin/MOAP-Management.git
cd MOAP-Backend && npm i && cd ..
cd MOAP-Front && npm i && cd ..
cd MOAP-Management && npm i && cd ..

./up.sh

# 初回起動時に非同期にDBの初期化が行われるため、しばらく待ってからmigrationを実行する
echo "コンテナを起動しました."
echo "データベースの初期化を待機しています."
sleep 10
./migrate.sh

./logs.sh

