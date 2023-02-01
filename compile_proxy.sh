#!/bin/bash
cd "$(dirname "$0")"

echo "Cloning"
git clone https://github.com/EpiSci/oai-lte-5g-multi-ue-proxy.git

echo "Taking the github-lte_handover" 
cd oai-lte-5g-multi-ue-proxy 

git checkout github-lte_handover


echo "Compiling"
make -j6

