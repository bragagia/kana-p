#!/bin/bash
pac=$(checkupdates | wc -l)

check=$((pac))
if [[ "$check" != "0" ]]
then
    echo " ${pac}"
fi
