# fish-getopts

fish-getopts is a command line options parser for the [fish shell](https://fishshell.com).

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

With [Fisher](https://github.com/jorgebucaran/fisher)

```
fisher add jorgebucaran/fish-getopts
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

