#!/bin/bash
cd "$(dirname "$0")"

oaiexist=$1

if [ "$oaiexist" = "" ]; then
  echo "Missing the variable to either clone the repository or use an existing one. 0 means cloning and 1 using the existing"
  exit 1
fi


./compile_oai.sh $oaiexist
./compile_proxy.sh
