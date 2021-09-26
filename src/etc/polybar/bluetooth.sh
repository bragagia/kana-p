#!/bin/bash

icon_enabled=""
icon_disabled=""
status=`echo $(rfkill list) | sed 's#^.*Bluetooth Soft blocked: \([^ ]*\) .*$#\1#g'`

if [ "${status}" == "no" ]
then
	echo "$icon_enabled"
else
	echo "$icon_disabled"
fi
