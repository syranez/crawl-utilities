#!/bin/env bash
#
# parses the score of a morgue file.
#
# Interface:
#    - collectScore: parse the score of a morgue file
#    - getScorce:    echoes the current accumulated score

#
# @access public
collectScore () {

    local file="$1";

    local line=`head -3 $file | tail -1`;

    SCORE=$((SCORE + `echo $line | awk '{print $1}'`));
}

#
# @access public
getScore () {

    echo $SCORE;
}

declare -i SCORE;
SCORE=0;
