# ruby/gem setup

# only need to set if gem is installed
which gem &>/dev/null
if test $status = 0
    fish_add_path (gem environment gempath | tr ':' '\n' | perl -ne "chomp \$_; if (m|^$HOME/.gem|) { print \$_ . \"\n\"; exit 0; }")/bin
end