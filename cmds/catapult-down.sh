#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

echo "catapultをシャットダウンしています"

cd $SCRIPT_DIR/../catapult/cmds && ./stop-all

