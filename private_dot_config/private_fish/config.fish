if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt; echo "\$ "; end

alias ls="ls -F"
alias ll="ls -Flgh"
alias la="ll -Fa"
alias  b="buku --suggest"
alias rm="trash"
