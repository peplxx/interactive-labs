#!/bin/bash

text=$(cat | base64 -w0)

curl -X POST -H "Content-Type: application/json" \
    -d "{\"data\":\"$text\"}" http://localhost:3000/clipboard
