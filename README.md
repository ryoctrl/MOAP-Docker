# MOAP-Docker
## Description
MOAPシステムをスタンドアロンな状態で構築するためのオールインワンなリポジトリ

## Plan
- MOAP-Backend
- MOAP-Front
- MOAP-Management
- MariaDB
    - [DockerHub](https://hub.docker.com/_/mariadb)
- NEM Catapult Node

## Problems
`docker-compose.yml`の`db`serviceに与えている.envが効果をなしていないのか、ユーザーとDBが初回に作成されない問題がある.
調査が必要であるが、それまでは初回に`docker-compose up`を行ったあとにdbへ接続しユーザーの作成とDBの作成をする必要がある.

```
cd MOAP-Docker

# DBのコンテナを確認
docker-compose ps

docker exec -it moap-docker_db_1(コンテナ名) /bin/bash

mysql

GRANT ALL PRIVILEGES ON *.* TO moap@"192.168.%.%" IDENTIFIED BY 'moap' WITH GRANT OPTION;
CREATE DATABASE moap;
exit

exit
```
