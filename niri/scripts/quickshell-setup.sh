#!/bin/sh

dir=/dev/shm/qshell
mkdir -p "$dir"

for corner in tl tr bl br cr cl; do
    touch "$dir/$corner-text"
    touch "$dir/$corner-color"
done

quickshell
