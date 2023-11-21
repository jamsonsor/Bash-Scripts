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

curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$CF_ZONEID/pagerules \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $CF_EMAIL" \
  --header "X-Auth-Key: $CF_GKEY" \
  --data '{
  "actions": [
    {
      "id": "browser_check",
      "value": "on"
    }
  ],
  "priority": 1,
  "status": "active",
  "targets": [
    {
      "constraint": {
        "operator": "matches",
        "value": "*devopsjam.com/help/*"
      },
      "target": "url"
    }
  ]
}' | jq .

curl --request DELETE \
  --url https://api.cloudflare.com/client/v4/zones/$CF_ZONEID/pagerules/f55cab1c756e9efe5af4e5d0356d19dc \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $CF_EMAIL" \
  --header "X-Auth-Key: $CF_GKEY" | jq .
