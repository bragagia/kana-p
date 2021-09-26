#!/bin/sh

cur=${1}

kger "X${cur}ZEUR" | xargs printf "${cur} %s€"
