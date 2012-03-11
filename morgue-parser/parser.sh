#!/bin/env bash
#
# Argument $1: Name of player

#
# plugins
#

# sum up the score
. scripts/scores.sh
# count the processed morgue files
. scripts/count.sh

#
# player 
#
declare PLAYER;
PLAYER=$1;

# parses a morgue file
#
# add here the collector plugins
#+ currently enabled:
#+    - scores.sh (sums up the score of a player)
#
# @param $file Path to morge file
parseMorgue () {

    local file="$1";

    collectScore $file;
    count $file;
}

for i in $(find $PLAYER -type f -name \*.txt)
do
    parseMorgue $i;
done;

count=$(getCount);
scores=$(getScore);
echo "$PLAYER has scored $scores points in $count runs.";
