#!/bin/bash

# Exit on error
set -e

clean_up() {
    if ps -p $SERVER_PID > /dev/null
    then
         kill $SERVER_PID
    fi
}
trap clean_up EXIT

# Test code goes here
$MRT_MARIAN/marian-server -c $MRT_MODELS/wmt16_systems/marian.en-de.yml -p 8765 \
    --alignment > server.align.log 2>&1 &
SERVER_PID=$!

sleep 20

python3 $MRT_MARIAN/../scripts/server/client_example.py -p 8765 < text.in > text.align.out
kill $SERVER_PID

$MRT_TOOLS/diff.sh text.align.out text.align.expected > text.align.diff

# Exit with success code
exit 0
