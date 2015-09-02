#!/bin/bash
 
for f in *; do
    if [ -d "$f/.git" ]; then
        pushd "$f" && git pull --quiet && popd
    fi
done