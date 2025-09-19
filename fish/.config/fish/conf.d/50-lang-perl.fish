# perl setup

set PERL_BIN_PATH /usr/bin/core_perl
if test -d $PERL_BIN_PATH
    fish_add_path $PERL_BIN_PATH
end
perl -Mlocal::lib &>/dev/null
if test $status = 0
    eval (perl -Mlocal::lib)
end