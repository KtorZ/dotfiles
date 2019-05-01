# Quickly search through files
alias grap='git grep -n'

# Reload profile, bashrc, bash_aliases etc...
alias refresh='source ~/.profile'

# Clean vim buffers
alias vclean='find . -name *.sw* -exec rm -i {} \; -o -name *.orig -exec rm -i {} \;'

# ¯\_(ツ)_/¯
alias shrug='echo "¯\\_(ツ)_/¯"'

# Markdown preview
function md() {
  livedown start $1 --open
}
