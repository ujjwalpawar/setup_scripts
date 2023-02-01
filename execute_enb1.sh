PATHTOOAI=~/openairinterface5g/
PATHTOPROXY=~/oai-lte-5g-multi-ue-proxy/

folder=$1

if [ "$folder" = "" ]; then
  echo "Missing the folder to save the logs"
  exit 1
fi

echo "Executing the eNBs"
cd $PATHTOOAI
source oaienv
cd cmake_targets/

sudo -E ./ran_build/build/lte-softmodem -O ../ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi.conf \
 --node-number 1 --emulate-l1 \
 --log_config.global_log_options level,nocolor,time,thread_id --log_config.global_log_level debug | tee ~/$folder/eNB1.log 2>&1 &

