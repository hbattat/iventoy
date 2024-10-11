#!/bin/bash

# Step 1: Get IPs from iVentoy
ip_response=$(curl -s 'http://localhost:26000/iventoy/json' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Language: en-US,en;q=0.9,ar;q=0.8' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: http://localhost:26000' \
  -H 'Pragma: no-cache' \
  -H 'Referer: http://localhost:26000/' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw '{"method":"sys_ip_list"}' \
  --insecure)

# Step 2: Extract necessary fields from the response
ip=$(echo $ip_response | jq -r '.[0].ip')
mask=$(echo $ip_response | jq -r '.[0].mask')
gw=$(echo $ip_response | jq -r '.[0].gw')
pool_begin=$(echo $ip_response | jq -r '.[0].pool_begin')
pool_end=$(echo $ip_response | jq -r '.[0].pool_end')

# Step 3: Start the iVentoy server
curl 'http://localhost:26000/iventoy/json' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Language: en-US,en;q=0.9,ar;q=0.8' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: http://localhost:26000' \
  -H 'Pragma: no-cache' \
  -H 'Referer: http://localhost:26000/' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw "{\"method\":\"start_server\",\"ip\":\"$ip\",\"mask\":\"$mask\",\"gw\":\"$gw\",\"pool_begin\":\"$pool_begin\",\"pool_end\":\"$pool_end\",\"dns_server\":\"\"}"
