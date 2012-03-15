#!/usr/bin/env bash
#
# Retrieves all linked morgue files from player stats page of http://crawl.akrasiac.org/scoring/players/
#
# Usage: ./develzmorgues.sh "player"

if [ ! $# -eq 1 ]; then
    echo 'Usage: ./develzmorgues.sh "player"';
    exit 1;
fi

PLAYER="$1";

# uri of the players stats page.
BASE_URI="http://crawl.akrasiac.org/scoring/players/${PLAYER}.html";

# all morge data is stored in this directory.
TEMP_DIR="/tmp/morgues";

# morge files of player $PLAYER are placed here.
TEMP_USER_DIR="${TEMP_DIR}/${PLAYER}";

# retrieved morgue file uris are temporarily stored in this file.
TEMP_URI_FILE=$(mktemp);

if [[ ! -e ${TEMP_USER_DIR} ]]; then
    mkdir -p "${TEMP_USER_DIR}";
fi

# collects the morgue file uris from the document
#
# @param uri of the document
# @side writes to $TEMP_URI_FILE
getUris () {

    if [ ! $# -eq 1 ]; then
        exit 1;
    fi

    wget "${1}" -q -O - | tr '>' '>\n' | grep '\.txt' | sed 's/^.*http/http/g' | sed 's/\.txt.*$/\.txt/g' > "${TEMP_URI_FILE}";
}

# retrieves all morgue files referenced in $1
#
# @param local file with uris to morge files
# @side writes data to $TEMP_USER_DIR
getMorgues () {

    if [[ ! -e $1 ]]; then
        exit 1;
    fi

    cd "${TEMP_USER_DIR}"
    wget -q --input-file="$1" -nc
    cd ~
}

getUris "${BASE_URI}";
getMorgues "${TEMP_URI_FILE}";
echo "Files written to ${TEMP_USER_DIR}";
