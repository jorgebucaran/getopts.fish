@mesg $current_filename

@test "standalone arguments" (getopts foo bar baz) = "_ foo _ bar _ baz"

@test "double dash (end of options)" (
    getopts foo -- bar -abc --baz fum
) = "_ foo _ bar _ -abc _ --baz _ fum"

@test "ignore the first double dash" -z (getopts --)

@test "don't ignore later double dashes" (getopts -- --) = "_ --"

@test "single dash operand (stdin)" (getopts --foo - bar) = "foo true _ - _ bar"
