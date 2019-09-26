#!/bin/bash

git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
git clone -b develop https://git.mosin.jp/git/mosin/MOAP-Front.git 
git clone https://git.mosin.jp/git/mosin/MOAP-Management.git
cd MOAP-Backend && npm i && cd ..
cd MOAP-Front && npm i && cd ..
cd MOAP-Management && npm i && cd ..

./up.sh

./migrate.sh

./logs.sh

