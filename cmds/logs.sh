#!/bin/bash

SCRIPT_DIR=$(cd $(BASH_SOURCE:-$0); pwd)

cd $SCRIPT_DIR/../ && docker-compose logs -f

