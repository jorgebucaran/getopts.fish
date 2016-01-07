function getopts () {
    if [ $# -eq 0 ]; then
        return 1
    fi

    printf "%s\n" $@ | sed -E '
        s/^-([A-Za-z]+)/- \1 /
        s/^--([A-Za-z0-9_-]+)(!?)=?(.*)/-- \1 \3 \2 /' | awk -f getopts.awk
}
