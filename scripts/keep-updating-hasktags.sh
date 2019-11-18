#!/usr/bin/env nix-shell
#!nix-shell -i bash -p entr fd haskellPackages.hasktags coreutils ncurses

fd '.*\.(hs|lhs|hsc)$' | entr -c sh -c 'echo "Updating tags $(tput setaf 2)$(date -Iseconds)$(tput sgr0)"; hasktags -cx .'
