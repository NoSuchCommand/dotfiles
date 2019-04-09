# Spot all broken symlinks in the current directory
function brokenlinks() {
    for f in *; do
        [ -e "$(readlink $f)" ] || echo $f
    done
}
