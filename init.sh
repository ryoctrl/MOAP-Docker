#!/bin/bash

git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
git clone -b develop https://git.mosin.jp/git/mosin/MOAP-Front.git 
git clone https://git.mosin.jp/git/mosin/MOAP-Management.git
cd MOAP-Backend && npm i && cd ..
cd MOAP-Front && npm i && cd ..
cd MOAP-Management && npm i && cd ..

./up.sh

docker exec -t moap-docker_backend_1 ./node_modules/.bin/sequelize db:migrate

./logs.sh

