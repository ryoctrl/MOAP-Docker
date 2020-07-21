#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

cd $SCRIPT_DIR/../ && docker-compose exec backend ./node_modules/.bin/sequelize db:migrate
cd $SCRIPT_DIR/../ && docker-compose exec queue ./node_modules/.bin/sequelize db:migrate
