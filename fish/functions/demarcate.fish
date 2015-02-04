function --description="Draw a demarcation" demarcate
    for i in (seq 1 (tput cols))
        echo -n "━"
    end
    echo ""
end
