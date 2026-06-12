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
    rebase -i "$@"
}

gitpush() {
  if ! git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    echo "no remote found, that would be a dry-run."
    return 1
  fi

  UNPUSHED="$(git cherry @{u} HEAD)"
  if [ -z "$UNPUSHED" ]; then
    echo "no unpushed commits found."
    return 0
  fi

  day=$(LC_ALL=C date +"%a")
  hour=$(date +"%H")
  if [ "$(check_allowed "$day" "$hour")" != "Allowed" ]; then
    echo "you can't push now because it would be visible."
    return 1
  fi

  current_time=$(date +%s)
  future_ts="$(git log --pretty=format:'%ct' | awk -v now="$current_time" '$1 > now { print $1; exit }')"
  if [ -n "$future_ts" ]; then
    echo "found commit with a future date (timestamp: ${future_ts})."
    return 1
  fi

  echo "pushing is allowed!"
  git push "$@"
}
