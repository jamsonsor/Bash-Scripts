#!/bin/bash

set -x

source ../.env

curl --request GET \
  --url https://api.cloudflare.com/client/v4/user \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $CF_TOKEN"