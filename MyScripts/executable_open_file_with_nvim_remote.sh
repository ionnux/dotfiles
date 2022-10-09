#!/usr/bin/bash
if [[ ! -z $1 ]]; then
    counter=1
    awesome-client '
    local apps = require("apps")
    local helpers = require("helpers")
    local editor = apps.editor
    helpers.focus_or_spawn({ app = apps.editor, back_and_forth = false, minimize_others = true })
    '
    connection_refused='.*connection refused.*'
    error_message=$(nvim --server /tmp/nvim.awesome_editor --remote-send "<C-\><C-N>:n $1<CR>" 2>&1)
    if [[ $error_message =~ $connection_refused ]]; then
        while [[ $counter -le 30 && ! -z $error_message ]]; do
            counter=$(( counter + 1 ))
            error_message=$(nvim --server /tmp/nvim.awesome_editor --remote-send "<C-\><C-N>:n $1<CR>" 2>&1)
            sleep 0.2
        done
    fi
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
