enb1=$1
if [ "$enb1" = "" ]; then
  echo "Missing enb1 id"
  exit 1
fi

enb2=$2
if [ "$enb2" = "" ]; then
  echo "Missing enb2 id"
  exit 1
fi

proxy=$3
if [ "$proxy" = "" ]; then
  echo "Missing proxy id"
  exit 1
fi

sed -i -e "s:execute_proxy.sh :execute_proxy.sh $enb1 $enb2 $proxy:g" execute_proxy_ue.sh

