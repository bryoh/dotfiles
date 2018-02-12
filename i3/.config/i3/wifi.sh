# Assumption 3 interfaces: loopback, ethernet, wifi
read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
#iwconfig returnns an error code if no wireless extensions

if iwconfig $int1 >/dev/null 2>&1; then
  wifi=$int1
  eth0=$int2
else
  wifi=$int2
  eth0=$int1
fi

# for now I only use wifi so 
int=wifi

ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi
RED='\033[0;31m'
GREEN='\033[0;32m'
#no colour
NC='\033[0m'
#echo -n "$int"
ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo -e "${GREEN} $(iwgetid -r)${NC}" ||
  echo "${GREEN}disconnected${NC}"
