#!/bin/bash
[[ "$#" -eq 2 ]] && >&2 echo "Command: $(realpath $0) $(readlink -m $1) $(readlink -m $2)"
>&2 diff $1 $2
