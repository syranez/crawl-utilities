#!/bin/env bash
#
# counts the morgue files.
#
# Interface:
#    - count:    processes the morgue file
#    - getCount: echoes the current processed morgue files count

#
# @access public
count () {

    COUNT=$((COUNT + 1));
}

#
# @access public
getCount () {

    echo $COUNT;
}

declare -i COUNT;
COUNT=0;
