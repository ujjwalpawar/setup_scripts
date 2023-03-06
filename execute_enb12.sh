#PATHTOOAI=~/openairinterface5g/
PATHTOOAI=~/openairinterface-nfapi-netsys/

echo "Executing the eNBs"
cd $PATHTOOAI
source oaienv
cd cmake_targets/

sudo -E ./ran_build/build/lte-softmodem -O ~/enb.conf $2 $3 \
  --node-number 1 --emulate-l1 \
 --log_config.global_log_options level,nocolor,time,thread_id --log_config.global_log_level $1 | tee ~/enb1.log 2>&1

