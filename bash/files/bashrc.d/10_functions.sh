#------------------------------------------------------------------------------#
#-- Functions
#------------------------------------------------------------------------------#

# Include the python venv name in purple if it exists
function venv_ps1() {
    if [ -n "$VIRTUAL_ENV" ]; then
        printf '[\001\e[35m\002%s\001\e[0m\002]' "$(basename $VIRTUAL_ENV)"
    fi
}

# Print input number in bold red if not zero
function bred_if_nz {
    if [ "$1" -gt 0 ]; then
        printf '\001\e[1;31m\002%3d\001\e[0m\002' "$1"
    else
        printf '%3d' "$1"
    fi
}
