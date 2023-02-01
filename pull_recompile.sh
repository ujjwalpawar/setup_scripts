#!/bin/bash
cd "$(dirname "$0")"
cd openairinterface5g
git pull
cd
./recompile_aoa.sh
