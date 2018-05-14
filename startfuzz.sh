#!/bin/bash

tmux new-session -d "Fuzzing cxxfilt" \; \
	split-window -h "/fuzz/afl-2.52b/afl-fuzz -i minimizedcorpus/ -o fuzzOutput -x symbols.dict -M master /fuzz/binutils-2.30/binutils/cxxfilt; read" \; \
	split-window -h "/fuzz/afl-2.52b/afl-fuzz -i minimizedcorpus/ -o fuzzOutput -x symbols.dict -S slavefuzz01 /fuzz/binutils-2.30/binutils/cxxfilt ; read" \; \
	split-window -d "/fuzz/afl-2.52b/afl-fuzz -i minimizedcorpus/ -o fuzzOutput -x symbols.dict -S slavefuzz02 /fuzz/binutils-2.30/binutils/cxxfilt ; read" \; \
	resize-pane -t 1 -L 6 \; \
	select-pane -t 1 \; \
	split-window -d "/fuzz/afl-2.52b/afl-fuzz -i minimizedcorpus/ -o fuzzOutput -x symbols.dict -S slavefuzz03 /fuzz/binutils-2.30/binutils/cxxfilt ; read" \; \
	attach-session -d
