#!/bin/bash
PATHTOOAI=~/openairinterface5g/
PATHTOPROXY=~/oai-lte-5g-multi-ue-proxy/

folder=$1

if [ "$folder" = "" ]; then
  echo "Missing the folder to save the logs"
  exit 1
fi


cd $PATHTOOAI

source oaienv
cd cmake_targets/ran_build/build/
sudo -E ./lte-uesoftmodem -O ../../../ci-scripts/conf_files/episci/proxy_ue.nfapi.conf \
 --L2-emul 5 --nokrnmod 1 --num-ues 1 --node-number 1 --num-enbs 2 \
 --log_config.global_log_options level,nocolor,time,thread_id --log_config.global_log_level debug | tee ~/$folder/UE.log 2>&1 # &> ~/$folder/UE.log  
