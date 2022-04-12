#!/bin/bash

count=1
fusermount -uzq ~/mnt
while [[ -z $(ls ~/mnt) && $count -le 4 ]]; do
    go-mtpfs ~/mnt
    sleep 3
    count=$(( count + 1 ))
done
