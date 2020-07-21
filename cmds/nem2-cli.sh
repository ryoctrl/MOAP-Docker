#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

docker run -it -v $SCRIPT_DIR/../nem2rc.json:/root/.nem2rc.json nem2-cli nem2-cli $@

