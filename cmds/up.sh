#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

$SCRIPT_DIR/catapult-up.sh
$SCRIPT_DIR/moap-up.sh

echo "MOAPとcatapultを起動しました"

