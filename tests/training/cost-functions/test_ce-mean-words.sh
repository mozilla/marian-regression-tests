#!/bin/bash -x

#####################################################################
# SUMMARY: Train using the 'ce-mean-words' cost function
# AUTHOR: snukky
#####################################################################

# Exit on error
set -e

# Test code goes here
rm -rf ce-mean-words ce-mean-words.log
mkdir -p ce-mean-words

$MRT_MARIAN/marian \
    --cost-type ce-mean-words \
    --seed 9999 \
    -m ce-mean-words/model.npz -t $MRT_DATA/train.max50.{en,de} -v vocab.en.yml vocab.de.yml \
    --disp-freq 2 --after-epochs 1 \
    --log ce-mean-words.log

test -e ce-mean-words/model.npz
test -e ce-mean-words.log

cat ce-mean-words.log | grep 'Ep\. 1 :' | $MRT_TOOLS/extract-costs.sh > ce-mean-words.out
$MRT_TOOLS/diff-nums.py ce-mean-words.out ce-mean-words.expected -p 0.02 -o ce-mean-words.diff

# Exit with success code
exit 0
