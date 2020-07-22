#!/bin/bash

body="{\"id\": \"$1\"}"
curl -X POST -H "Content-Type: application/json" -d "$body" http://localhost:9250/api/user/register
