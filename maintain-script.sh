#!/bin/zsh

TIME="$(date '+%Y-%m-%d %H:%M:%S %z')"
MSG="update at $TIME"

if [[ $(git config user.name) == '' && $(git config user.email) == '' ]]; then
  echo "Error: First config git user"
  exit 1
fi

# 是否有修改
if [[ -n $(git status --porcelain=v1 2>/dev/null) ]]; then
  git add .
  git commit -m "$MSG"
  echo $MSG
  git push
else
  echo "clean, check at $TIME"
fi