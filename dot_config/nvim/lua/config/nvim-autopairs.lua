require('nvim-autopairs').setup({
    map_bs = true, -- map the <BS> key
    disable_filetype = {"TelescopePrompt"},
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    enable_moveright = true,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
    check_ts = true,
    fast_wrap = {
        map = '<c-f>',
        chars = {'{', '[', '(', '"', "'"},
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        hightlight = 'Search'
    }
})

local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

-- add space between paranthesis
npairs.add_rules {
    Rule(' ', ' '):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({'()', '[]', '{}'}, pair)
    end), Rule('( ', ' )'):with_pair(function() return false end):with_move(
        function(opts) return opts.prev_char:match('.%)') ~= nil end):use_key(
        ')'),
    Rule('{ ', ' }'):with_pair(function() return false end):with_move(
        function(opts) return opts.prev_char:match('.%}') ~= nil end):use_key(
        '}'), Rule('[ ', ' ]'):with_pair(function() return false end):with_move(
        function(opts) return opts.prev_char:match('.%]') ~= nil end):use_key(
        ']')
}
