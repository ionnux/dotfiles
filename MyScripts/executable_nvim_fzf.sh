#!/usr/bin/fish

~/MyScripts/open_file_with_nvim_remote.sh (fd -H -t f -L -c always . ~ -E '*.{html,json,txt,svg,xml,c,h,jpeg,a,avi,jpg,mp3,png,ttf,class,epub,bin,mp4,mkv,jar,webp,pdf,apk,zip,tar,gz,deb}' -E '*.so' -E '*.so.*'  | fzf --ansi --no-reverse --no-height)
# ~/MyScripts/open_file_with_nvim_remote.sh (fzf --no-reverse --no-height --ansi)
