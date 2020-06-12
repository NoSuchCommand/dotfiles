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

# Spot all broken symlinks in the current directory
function brokenlinks() {
    local f t
    for f in *; do
        [ -L "$f" ] || continue
        t=$(realpath "$f")
        [ -e "$t" ] || echo $f
    done
}

# Globally cleanup trailing spaces inside files of a git repo
function eol_cleanup {
    git status &> /dev/null || {
        printf 'Error: Not inside a git repository !\n' >&2
        return 1
    }

    local f

    git ls-files | while read f; do
        file -b --mime-type "$f" | grep -q ^text/ && sed -ri 's/\s+$//' "$f"
    done
}

# Show URL for opening a github issue regarding multiple lines
# Espacially useful for non-code files (like asciidoc)
function ghissue() {
    (( $# < 2 )) && {
        printf 'Usage: ghissue FILE STARTLINE [ENDLINE]\n' >&2
        return 1
    }
    git status &> /dev/null || {
        printf 'Error: Not inside a git repository !\n' >&2
        return 2
    }
    local file=$(realpath "$1")
    local gitroot=$(git rev-parse --show-toplevel)
    local gitfile=${file#${gitroot}/}
    local startline="$2" endline="$3"
    local repo=$(git remote -v |
                 awk '/^origin.*\(fetch\)/ {
                          sub("\\.git$", "", $2);
                          sub("[^/]*@github.com", "github.com", $2);
                          print $2;
                      }'
                )
    local commit=$(git log -n 1 --format=%H -- "$file")

    printf '%s/blob/%s/%s#L%s%s\n' "$repo"                  \
                                   "$commit"                \
                                   "$gitfile"               \
                                   "$startline"             \
                                   "${endline:+-L$endline}"
    return 0
}
