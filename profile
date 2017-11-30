if [ -d "$HOME/.nix-profile/etc/profile.d" ]; then
    for f in $HOME/.nix-profile/etc/profile.d/*; do
        source $f
    done
fi
