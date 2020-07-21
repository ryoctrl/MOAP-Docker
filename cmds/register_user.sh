#!/bin/bash

set -eux 
body="{\"id\": \"$1\"}"
echo $body
curl -X POST -H "Content-Type: application/json" -d "$body" localhost:9250/api/user/register
