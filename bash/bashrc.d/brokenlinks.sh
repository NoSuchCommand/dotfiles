# Spot all broken symlinks in the current directory
function brokenlinks() {
    local f t
    for f in *; do
        [ -L "$f" ] || continue
        t=$(realpath "$f")
        [ -e "$t" ] || echo $f
    done
}
