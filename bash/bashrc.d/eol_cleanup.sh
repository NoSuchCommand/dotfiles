# Globally cleanup trailing spaces inside files of a git repo
function eol_cleanup {
    git status &> /dev/null || {
        printf 'Error: Not inside a git repository !\n' >&2
        return 1
    }

    local f

    git ls-files | while read f; do
        file -b --mime-type "$f" | grep ^text/ && sed -ri 's/\s+$//' "$f"
    done
}
