# add this to your .zshrc file

check_allowed() {
  day="$1"
  hour="$2"
  if [ "$day" = "Sat" ] || [ "$day" = "Sun" ]; then # allow on the weekends
    echo "Allowed"
  else                         # weekdays
    if [ "$hour" -lt 9 ]; then # allow before 9am
      echo "Allowed"
    elif [ "$hour" = 12 ]; then # allow between 12pm and 1pm
      echo "Allowed"
    elif [ "$hour" -ge 23 ]; then # allow after 11pm
      echo "Allowed"
    else
      echo "Not allowed"
    fi
  fi
}

gitrebase() {
  git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" git commit --amend --no-edit --allow-empty --allow-empty-message' \
    rebase -i $@
}

gitpush() {
  DATE="date"

  if ! git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    echo "no remote found, that would be a dry-run."
    return 1
  fi

  UNPUSHED="$(git cherry @{u} HEAD)"
  if [ -z "$UNPUSHED" ]; then
    echo "no unpushed commits found."
    return 0
  fi

  day=$($DATE +"%a")
  hour=$($DATE +"%H")

  current_time=$($DATE +%s)
  temp_file="$(mktemp)" || return 1
  if [ "$(check_allowed "$day" "$hour")" != "Allowed" ]; then
    echo "you can't push now because it would be visible."
    return 1
  fi

  git log --pretty=format:'%ct' | while IFS= read -r commit_ts; do
    if [ "$commit_ts" -gt "$current_time" ]; then
      echo "$commit_ts" >"$temp_file"
      break
    fi
  done

  if [ -s "$temp_file" ]; then
    echo "found commit with a future date (timestamp: $(cat "$temp_file"))."
    rm -f "$temp_file"
    return 1
  fi

  echo "pushing is allowed!"
  rm -f "$temp_file"
  git push "$@"
}
