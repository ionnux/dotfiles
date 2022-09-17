#!/usr/bin/bash

counter=1
awesome-client 'require("apps").editor()' &&
connection_refused='.*connection refused.*'
error_message=$(nvim --server /tmp/nvim.editor --remote-send "<C-\><C-N>:n $1<CR>" 2>&1)
if [[ $error_message =~ $connection_refused ]]; then
    while [[ $counter -le 30 && ! -z $error_message ]]; do
        counter=$(( counter + 1 ))
        error_message=$(nvim --server /tmp/nvim.editor --remote-send "<C-\><C-N>:n $1<CR>" 2>&1)
        sleep 0.2
    done
fi
# error_message=$(nvim --server /tmp/nvim.editor --remote-send ':echo""<cr>' 2>&1)
# if [[ $error_message =~ $connection_refused ]]; then
#     while [[ $counter -le 30 && ! -z $error_message ]]; do
#         counter=$(( counter + 1 ))
#         error_message=$(nvim --server /tmp/nvim.editor --remote-send ':echo""<cr>' 2>&1)
#         sleep 0.2
#     done
# fi

# if [[ -z $error_message ]]; then
#     nvim --server /tmp/nvim.editor --remote-send "<C-\><C-N>:n $1<cr>"
#     # nvim --server /tmp/nvim.editor --remote "$1"
# fi
