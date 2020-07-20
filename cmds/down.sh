#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

$SCRIPT_DIR/moap-down.sh
$SCRIPT_DIR/catapult-down.sh

echo "MOAPとcatapultをシャットダウンしました"

