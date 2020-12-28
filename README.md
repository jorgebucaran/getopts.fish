# getopts.fish

> Parse CLI options in Fish.

Getopts is a CLI options parser for [Fish](https://fishshell.com) based on the [POSIX Utility Syntax Guidelines](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html#tag_12_02). Think [`argparse`](https://fishshell.com/docs/current/commands.html#argparse) without the domain specific language, implicit variables, complex option spec, or companion commands.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install jorgebucaran/getopts.fish
```

## Quickstart

The `getopts` command splits your arguments into key-value records that can be read into variables.

```fish
$ engage --quadrant=delta -w9 <coordinates.dat
```

```fish
function engage -d "activate the warp drive"
    set -l warp 1
    set -l quadrant alpha
    set -l coordinates

    getopts $argv | while read -l key value
        switch $key
            case _
                while read -l target
                    set coordinates $coordinates $target
                end < $value
            case q quadrant
                set quadrant $value
            case w warp
                set warp $value
            case h help
                _engage_help >&2
                return
            case v version
                _engage_version >&2
                return
        end
    end

    if not set -q coordinates[3]
        echo "engage: invalid coordinates" >&2
        return 1
    end

    _engage_activate $warp $quadrant $coordinates
end
```

## Parsing Rules

### Short Options

A short option consists of a hyphen `-` followed by a single alphabetic character. Multiple short options can be clustered together without spaces. A short option will be `true` unless followed by an [operand](#operand) or if immediately adjacent to one or more non-alphabetic characters matching the regular expression <code>/!-@[-`{-~/</code>.

```console
$ getopts -ab -c
a true
b true
c true
```

```console
$ getopts -a alppha
a alpha
```

The argument following a short or a long option (which is not an option itself) will be parsed as its value. That means only the last character in a cluster of options can receive a value other than `true`.

```console
$ getopts -ab1 -c -d
a true
b 1
c true
d true
```

Symbols, numbers and other non-alphabetic characters can be used as an option if they're the first character after a hyphen.

```console
$ getopts -9 -@10 -/0.01
9 true
@ 10
/ 0.01
```

### Long Options

A long option consists of two hyphens `--` followed by one or more characters. Any character, including symbols, and numbers can be used to create a long option except for the `=` symbol, which separates the option's key and value.

```console
$ getopts --turbo --warp=10
turbo true
warp 10
```

```console
$ getopts --warp=e=mc\^2
warp e=mc^2
```

```console
$ getopts ---- alpha
-- alpha
```

### Operands

Every non-option standalone argument will be treated as an operand, and its key will be an underscore `_`.

```console
$ getopts alpha -w9
_ alpha
w 9
```

```console
$ getopts --code=alpha beta
code alpha
_ beta
```

Every argument after the first double-hyphen sequence `--` will be treated as an operand.

```console
$ getopts --alpha -- --beta gamma
alpha true
_ --beta
_ gamma
```

A single hyphen `-` is always an operand.

```console
$ getopts --alpha -
alpha true
_ -
```

## License

[MIT](LICENSE.md)
