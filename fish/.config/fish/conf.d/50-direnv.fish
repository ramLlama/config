# direnv setup

which direnv &>/dev/null
if test $status = 0
    direnv hook fish | source
end