#!/bin/bash

folder=$1
if [ "$folder" = "" ]; then
  echo "Missing the folder to save the logs"
  exit 1
fi

rm -rf $folder/ping.txt


while [ 1 ]
do
  ping -I oaitun_ue1 -c 1 10.45.0.1 2>&1 >/dev/null
  if [ "$?" = 0 ]
  then
    echo "Host found"
    ping -I oaitun_ue1 10.45.0.1 > ~/$folder/ping.txt
    break
  else
    echo "Host not found"
  fi
done

