gitrebase() {
  git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" git commit --amend --no-edit --allow-empty --allow-empty-message' \
    rebase -i $@
}
