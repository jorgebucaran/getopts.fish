@mesg $current_filename

@test "without value" (getopts --foo) = "foo true"

@test "as the last argument" (getopts --foo=bar --baz) = "foo bar baz true"

@test "implicit value" (getopts --foo 001 --bar baz) = "foo 001 bar baz"

@test "explicit value" (getopts --foo=001 --bar=baz) = "foo 001 bar baz"

@test "name may be formed by any characters" (
    getopts --foo 01 --bar=2 --baz3 --34m
) = "foo 01 bar 2 baz3 true 34m true"

@test "split value after first =" (getopts --foo=e=mc\^2) = "foo e=mc^2"

@test "mixed boolean, string, and numbers" (
    getopts --foo bar baz --fum --bam=pow --qux 0.1
) = "foo bar _ baz fum true bam pow qux 0.1"

@test "empty strings and other characters" (
    getopts --foo=/foo/bar/baz foobar --fum= --bam=.99 --pow=@
) = "foo /foo/bar/baz _ foobar fum  bam .99 pow @"

@test "more special characters" (
    getopts --@foo=bar ----bg-color=red --=void
) = "@foo bar --bg-color red  void"
