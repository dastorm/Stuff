#!/bin/bash
# Requires: wmctrl xprop

##################################
# Adjust values to suit
PANEL_NUM=0
PANEL_ALPHA_REGULAR=0
PANEL_ALPHA_MAXIMUM=80
##################################
##################################
# don't change anything below here
CURR=0
while true
do
	MAX_FND=0
	for w in $( wmctrl -l | cut -d' ' -f1 )
   	do 
		if xprop -id $w | grep -E "MAXIMIZED_HORZ.*MAXIMIZED_VERT" > /dev/null 2>&1
		then
			MAX_FND=1
			break
		fi
	done

	if [[ $MAX_FND -eq 1 && $CURR -eq 0 ]]
	then 
		xfconf-query -c xfce4-panel -p /panels/panel-$PANEL_NUM/background-alpha -s $PANEL_ALPHA_MAXIMUM
		CURR=1			
	elif [[ $MAX_FND -eq 0 && $CURR -eq 1 ]]
	then
		xfconf-query -c xfce4-panel -p /panels/panel-$PANEL_NUM/background-alpha -s $PANEL_ALPHA_REGULAR
		CURR=0
	fi

	sleep 1
done
exit 0