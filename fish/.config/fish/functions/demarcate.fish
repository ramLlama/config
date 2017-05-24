function demarcate --description="Draw a demarcation"
    for i in (seq 1 (tput cols))
        echo -n "━"
    end
    echo ""
end
