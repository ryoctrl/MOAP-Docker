#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

echo "moapを起動しています"

cd $SCRIPT_DIR/../ && docker-compose up -d

