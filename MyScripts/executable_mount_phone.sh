#!/bin/bash

count=1
fusermount -uzq ~/mnt
while [[ -z $(ls ~/mnt) && count -le 2 ]]; do
    go-mtpfs ~/mnt
    count=$(( count + 1 ))
    echo count
    sleep 4
done
echo done
