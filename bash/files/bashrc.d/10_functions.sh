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
        file -b --mime-type "$f" |
                         grep -q ^text/ &&
                         sed -ri 's/\s+$//' "$f"
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

# Activate a venv
function vv() {
    [[ -n "$1" ]] || {
        echo "Error: no venv name given." >&2
        return 1
    }
    [[ -n "$VENVS_BASE" ]] || {
        echo "Error: please set VENVS_BASE." >&2
        return 1
    }
    source $VENVS_BASE/$1/bin/activate
}

# Remove line from SSH known_hosts
# rkh = remove know hosts
function rkh() {
    [[ "$1" =~ ^[0-9]+$ ]] || {
        echo "Please provide a line numer"
        return 1
    }
    sed -i "$1 d" ~/.ssh/known_hosts
}

# Fuzzy-search-goto git repositories
function repo() {
    [[ -n "${GIT_REPOS_PATH//[[:space:]]/}" &&
       -d "$GIT_REPOS_PATH" &&
       -r "$GIT_REPOS_PATH" &&
       -x "$GIT_REPOS_PATH" ]] || {
        echo 'Fatal: Variable GIT_REPOS_PATH does not point to a valid directory'
        return 1
    }

    [[ -n "${GIT_REPOS_CACHE//[[:space:]]/}" ]] || {
        echo 'Fatal: Variable GIT_REPOS_CACHE is not defined'
        exit 2
    }

    local query="" target dest
    if (( $# > 0 )); then
        query="--query=$1"
    fi

    target=$(fzf $query --read0 < "$GIT_REPOS_CACHE")

    if [[ -n "$target" ]]; then
        dest="$GIT_REPOS_PATH"/"$target"
        cd "$dest" || {
            echo "Fatal: Could not change directory to ${dest}"
            return 10
        }
    fi
}

function _set_title() {
    if [[ -n "$TERM_TITLE" ]]; then
        echo -ne "\033]0;$TERM_TITLE\007"
    fi
}

function title() {
    (( $# >= 1 )) || {
        echo "Error: missing argument title"
        return 1
    }
    if [[ -z "$*" ]]; then
        unset TERM_TITLE
    else
        export TERM_TITLE="$*"
    fi
}
