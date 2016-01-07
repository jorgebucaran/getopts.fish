<p align="center">
  <a href="http://github.com/bucaran/getopts">
    <img alt="getopts" width=500px  src="https://cloud.githubusercontent.com/assets/8317250/12137933/266fbd1e-b498-11e5-80cc-eb0389ad4d04.png">
  </a>
</p>

[![][travis-badge]][travis-link]

## Synopsis

```fish
getopts arguments
```

## Description

`getopts` is a [command line parser](https://en.wikipedia.org/wiki/Command-line_interface#Arguments) written in AWK, designed to process command line arguments according to the POSIX Utility Syntax [Guidelines](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html).

## Install

```
git clone https://github.com/bucaran/getopts
```

Drop `getopts.{awk,fish}` in your `~/.config/fish/functions` if you are using fish or edit your `$fpath` or similar for bash or zsh.

## Usage

In the following example:

```fish
getopts -ab1 --foo=bar baz
```

And its output:

```fish
a
b    1
foo  bar
_    baz
```

The items on the _left_ represent the option flags or *keys* associated with the CLI. The items on the _right_ are the option *values*. The underscore `_` character is the default *key* for arguments without a key.

## Examples

### [Fish][fish]

Use [`read(1)`](http://fishshell.com/docs/current/commands.html#read) to process the generated stream and [`switch(1)`](http://fishshell.com/docs/current/commands.html#switch) to match patterns:

```fish
getopts -ab1 --foo=bar baz | while read -l key option
    switch $key
        case _
        case a
        case b
        case foo
    end
end
```

The following is a mock of [`fish(1)`](http://fishshell.com/docs/current/commands.html#fish) CLI missing the implementation:

```fish
function fish
    set -l mode
    set -l flags
    set -l commands
    set -l debug_level

    getopts $argv | while read -l key value
        switch $key
            case c command
                set commands $commands $value

            case d debug-level
                set debug_level $value

            case i interactive
                set mode $value

            case l login
                set mode $value

            case n no-execute
                set mode $value

            case p profile
                set flags $flags $value

            case h help
                printf "usage: $_ [OPTIONS] [-c command] [FILE [ARGUMENTS...]]\n"
                return

            case \*
                printf "$_: '%s' is not a valid option.\n" $key
                return 1
        end
    end

    # Implementation missing...
end
```

### [zsh][zsh]

In zsh case, use builtin commands in the same way as fish shell:

```zsh
getopts -ab1 --foo=bar baz | while read key option
    case $key
        _)  ;;
        a)  ;;
        b)  ;;
        foo ;;
    esac
end
```

## Bugs

* `getopts` does **not** read the standard input. Use `getopts` to collect options and the standard input to process a stream of data relevant to your program.

* A double dash, `--`, marks the end of options. Arguments after this sequence are placed in the default underscore key, `_`.

* The `getopts` described in this document is **not** equivalent to the `getopts` *builtin* found in other shells.


## See Also

* POSIX [Utility Syntax Guidelines](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html)<br>

<!-- Links -->
[travis-link]:  https://travis-ci.org/bucaran/getopts
[travis-badge]: https://img.shields.io/travis/bucaran/getopts.svg?style=flat-square

[fish]: https://github.com/fish-shell/fish-shell
[zsh]: https://github.com/zsh-users/zsh
