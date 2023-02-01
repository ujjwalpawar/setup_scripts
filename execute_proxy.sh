#!/bin/bash

ipenb1=$1

if [ "$ipenb1" = "" ]; then
  echo "Missing the enb1 ip"
  exit 1
fi

ipenb2=$2

if [ "$ipenb2" = "" ]; then
  echo "Missing the enb2 ip"
  exit 1
fi

ipproxy=$3

if [ "$ipproxy" = "" ]; then
  echo "Missing the proxy ip"
  exit 1
fi

PATHTOOAI=~/openairinterface5g/
PATHTOPROXY=~/oai-lte-5g-multi-ue-proxy/

folder=$4

if [ "$folder" = "" ]; then
  echo "Missing the folder to save the logs"
  exit 1
fi

echo "Executing proxy"
cd $PATHTOPROXY
sudo -E ./build/proxy 1 $ipenb1 $ipenb2 $ipproxy 127.0.0.1 --lte_handover | tee ~/$folder/proxy.log 2>&1
