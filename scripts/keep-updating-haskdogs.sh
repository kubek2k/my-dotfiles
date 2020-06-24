#!/usr/bin/env nix-shell
#!nix-shell -i bash -p entr fd ghc haskellPackages.haskdogs haskellPackages.hasktags haskellPackages.cabal-install coreutils ncurses

if [ $# -eq 0 ]; then
    DIRS="."
else
    DIRS="$*"
fi

haskdogs --hasktags-args "-cx $DIRS"

fd '.*\.(hs|lhs|hsc|cabal|project)$' | entr -c sh -c "echo \"Updating tags \$(tput setaf 2)\$(date -Iseconds)\$(tput sgr0)\$0\" && 
    if [[ \"\$0\" =~ \"cabal\" ]]; then 
        echo \"Change in cabal files detected - invoking haskdogs\"
        haskdogs --hasktags-args \"-cx $DIRS\" 
    else 
        hasktags -cx $DIRS 
    fi" /_
