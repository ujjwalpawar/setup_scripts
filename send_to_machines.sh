#!/bin/bash
pc=$1
if [ "$pc" = "" ]; then
  echo "Missing pc id"
  exit 1
fi

echo "Copying the scipts"
scp * alexbp@pc${pc}.emulab.net:~/
ssh alexbp@pc${pc}.emulab.net chmod +x *.sh

