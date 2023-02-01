#!/bin/bash
cd "$(dirname "$0")"

ipenb1=$1

if [ "$ipenb1" = "" ]; then
  echo "Missing the source ip" 
  exit 1
fi

ipenb2=$2

if [ "$ipenb2" = "" ]; then
  echo "Missing the target ip"
  exit 1
fi

ipepc=$3

if [ "$ipepc" = "" ]; then
  echo "Missing the epc ip"
  exit 1
fi

ipproxy=$4

if [ "$ipproxy" = "" ]; then
  echo "Missing the proxy ip"
  exit 1
fi
cp -a openairinterface5g/ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi_target.conf ~/enb.conf
sed -i -e 's/"lo:"/"eno1"/g' openairinterface5g/ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi_target.conf

# modifying source ip 
sed -i -e "s:127.0.0.1:$ipenb1:g" ~/enb.conf
sed -i -e "s:192.168.61.3:$ipepc:g" ~/enb.conf 
sed -i -e "s:127.0.0.2:$ipenb2:g" ~/enb.conf 
str1=\""$ipenb1"\"
str2="remote_s_address = "$str1
echo $str2

str3=\""$ipproxy"\"
str4="remote_s_address = "$str3
echo $str4


sed -i -e "s:$str2:$str4:g" ~/enb.conf 
#sed -i -e 's:192.168.61.3:127.0.0.100:g' openairinterface5g/ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi_target.conf

sed -i -e 's:320:208:g' ~/enb.conf 
sed -i -e 's:230:93:g' ~/enb.conf 
sed -i -e 's:mnc_length = 3:mnc_length = 2:g' ~/enb.conf 

