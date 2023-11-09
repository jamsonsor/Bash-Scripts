#!/bin/bash

set +x

source ../.env

curl --request GET \
  --url https://api.cloudflare.com/client/v4/user \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $CF_EMAIL" \
  --header "X-Auth-Key: $CF_GKEY" | jq .result.username

curl --request GET \
  --url https://api.cloudflare.com/client/v4/zones \
  --header "Authorization: Bearer $CF_READ_TOKEN" \
  --header 'Content-Type: application/json' | jq .result[].name

curl --request GET \
  --url https://api.cloudflare.com/client/v4/zones/$CF_ZONEID/firewall/rules \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $CF_EMAIL" \
  --header "X-Auth-Key: $CF_GKEY" | jq .