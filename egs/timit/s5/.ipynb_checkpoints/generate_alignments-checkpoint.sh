#!/bin/bash

. ./cmd.sh
[ -f path.sh ] && . ./path.sh
set -e

for x in train test dev; do
    for alignment in exp/mono_ali_$x/ali.*.gz; do
        echo "aligning data in $alignment"
        ali-to-phones --per-frame exp/mono/final.mdl "ark:gunzip -c $alignment |" ark,t:- | utils/int2sym.pl -f 2- data/lang/phones.txt > $alignment.txt
    done
    cat exp/mono_ali_$x/ali.*.gz.txt > alignments_$x
done
