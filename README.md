[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Getopts

**Getopts** is a command line options parser for [fish].

```fish
getopts -ab1 --foo=bar baz | while read -l key value
    switch $key
        case _
            echo "$value" # baz
        case a
            echo "$value" # ""
        case b
            echo "$value" # 1
        case foo
            echo "$value" # bar
    end
end
```

## Install

With [fisherman]

```
fisher getopts
```

With curl.

```sh
curl -Lo ~/.config/fish/functions/getopts.fish --create-dirs git.io/getopts
```

## Usage

Study the output in the following example

```fish
getopts -ab1 --foo=bar baz
```

```
a
b    1
foo  bar
_    baz
```

The items on the left are the option flags. The items on the right are the option values. The underscore `_` character is the default *key* for bare arguments.

Use read(1) to process the generated stream and switch(1) to match patterns

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

## Notes

* A double dash, `--`, marks the end of options. Arguments after this sequence are placed in the default underscore key, `_`.

[travis-link]: https://travis-ci.org/fisherman/getopts
[travis-badge]: https://img.shields.io/travis/fisherman/getopts.svg

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg

[fish]: https://fishshell.com
[fisherman]: https://github.com/fisherman/fisherman
