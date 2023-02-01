#!/bin/bash
cd "$(dirname "$0")"

ipproxy=$1

if [ "$ipproxy" = "" ]; then
  echo "Missing the proxy ip" 
  exit 1
fi
echo $ipproxy
sed -i -e "s:127.0.0.100:$ipproxy:g" config.yaml 
