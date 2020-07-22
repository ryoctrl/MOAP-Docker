#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

echo "catapultを起動しています"

#cd $SCRIPT_DIR/../catapult/cmds/bootstrap && docker-compose up -d
cd $SCRIPT_DIR/../catapult/cmds/ && ./start-all -d


