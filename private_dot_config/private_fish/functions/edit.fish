function edit --wraps=$EDITOR --description 'Open file in EDITOR'
    eval "$EDITOR $argv[1]"
end
