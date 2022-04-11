#!/bin/bash

count=1
while [[ -z $(ls ~/mnt) && $count -le 4 ]]; do
    fusermount -uzq ~/mnt
    go-mtpfs ~/mnt
    sleep 3
    count=$(( count + 1 ))
done
