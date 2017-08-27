#!/bin/sh

while :
do
sleep 1	
	
	CMUS=$( cmus-remote -Q 2>/dev/null )
	STATUS=$( echo "$CMUS" | grep -o 'status [^\$]\+' | cut -d " " -f 2- )
	ARTIST=$( echo "$CMUS" | grep -o 'tag artist [^\$]\+' | cut -d " " -f 3- )
	TITLE=$( echo "$CMUS" | grep -o 'tag title [^\$]\+' | cut -d " " -f 3- )


	if [ "$STATUS" = "playing" ]; then
		Cstat=" $TITLE |"
	elif [ "$STATUS" = "paused" ]; then
		Cstat=" $TITLE |"
	else
		Cstat=""

	fi

	vol1=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
		    head -n $(( $SINK + 2 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')


	if ["$vol1" == "0"]; then
	vol=" $vol1 %"
	else
	vol=" $vol1 %"
	fi

	pow=$(upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" | grep percentage)

	short=${pow:23:25}
	full=" $short"
	echo "$Cstat $vol | $full | $(date)"


	
done
