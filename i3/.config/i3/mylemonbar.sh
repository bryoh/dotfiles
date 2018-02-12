date '+%b-%d %a %M:%H'

BATC=/sys/class/power_supply/BAT0/capacity
BATS=/sys/class/power_supply/BAT0/status

#Add percentage + or - depending on whether we are charging 
test "`cat $BATS`" = "Charging" && echo -n '+' || echo -n '-'

#print out the content 
watch -n -1 $BATC
