#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

echo "moapをシャットダウンしています"

cd $SCRIPT_DIR/../ && docker-compose down

