complete -W '$(find $VENVS_BASE -maxdepth 1 -mindepth 1 -type d -printf "%f\n")' vv
