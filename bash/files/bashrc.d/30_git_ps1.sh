source /usr/share/git-core/contrib/completion/git-prompt.sh

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

BEGIN_PS1='[$(bred_if_nz $?)]$(venv_ps1)'
END_PS1='[\u@\h \W]\$ '

PROMPT_COMMAND="__git_ps1 '$BEGIN_PS1' '$END_PS1' '[%s]'; $PROMPT_COMMAND"
export PROMPT_COMMAND

unset BEGIN_PS1 END_PS1
