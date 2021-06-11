# Location where asdf install plugins, shims and installs.
set -x ASDF_DATA_DIR ~/.local/asdf
set -x ASDF_CONFIG_FILE ~/.config/asdfrc

# Location of the asdf scripts.
if test -d /opt/asdf-vm;
    set -gx ASDF_DIR /opt/asdf-vm
else
    set -gx ASDF_DIR $ASDF_DATA_DIR
end

if not test -d $ASDF_DIR
    printf "asdf is not installed. Run the following command to install:\n
    `git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.8.1`"
end

source $ASDF_DIR/asdf.fish
