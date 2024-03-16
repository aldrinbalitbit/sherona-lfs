_echo() {
    echo -e "${@}"
}

_banner() {
    _echo ""
}

_err() {
    _echo "\e[1;31m${1}\e[m"
}

_msg() {
    _echo "\e[1;32m${1}\e[m"
}

_warn() {
    _echo "\e[1;33m${1}\e[m"
}

# Build functions
