#!/bin/bash

body="{\"id\": \"$1\"}"
curl -X POST -H "Content-Type: application/json" -d "$body" localhost:9250/api/user/register
