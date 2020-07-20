#!/bin/bash

echo "MOAPを起動しています"

docker-compose up -d

echo "catapultを起動しています"

cd catapult/cmds/bootstrap && docker-compose up -d

echo "MOAPとcatapultを起動しました"

