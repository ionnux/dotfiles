#!/bin/bash

fusermount -uzq ~/mnt
while [[ -z $(ls ~/mnt) ]]; do
    go-mtpfs ~/mnt
    sleep 4
done
