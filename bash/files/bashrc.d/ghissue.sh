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
