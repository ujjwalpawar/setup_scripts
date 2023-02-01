pc=$1
if [ "$pc" = "" ]; then
  echo "Missing pc id"
  exit 1
fi 

ssh alexbp@pc${pc}.emulab.net sudo apt update
ssh alexbp@pc${pc}.emulab.net sudo apt install -y lksctp-tools
ssh alexbp@pc${pc}.emulab.net 'echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections'
ssh alexbp@pc${pc}.emulab.net sudo apt install -y tshark

./send_to_machines.sh $pc
