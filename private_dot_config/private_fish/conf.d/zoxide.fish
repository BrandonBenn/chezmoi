zoxide init fish | source

function z
    if count $argv > /dev/null
        __zoxide_z "$argv"; and ls
    else
        __zoxide_z ~; and ls
    end
end

function zi
    __zoxide_zi; and ls
end
