# haskell/cabal setup

set CABAL_BIN_PATH {$HOME}/.cabal/bin
if test -d $CABAL_BIN_PATH
    fish_add_path $CABAL_BIN_PATH
end