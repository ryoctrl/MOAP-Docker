#!/bin/bash

echo "MOAPをシャットダウンしています"

docker-compose down

echo "catapultをシャットダウンしています"

cd catapult/cmds/bootstrap && docker-compose down

echo "MOAPとcatapultをシャットダウンしました"

