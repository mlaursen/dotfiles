#!/bin/sh

OLD_EMAIL="$1"
NEW_EMAIL=="mlaursen03@gmail.com"
NEW_NAME="Mikkel Laursen"

while [[ $# -gt 0 ]]; do
  arg="$1"

  case $arg in
    -o|--old)
      shift
      OLD_EMAIL="$1"
      shift
      ;;
    -n|--name)
      shift
      NEW_NAME="$1"
      shift
      ;;
    -e|--email)
      shift
      NEW_EMAIL="$1"
      shift
      ;;
    *)
      shift
  esac
done

git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]; then
  export GIT_COMMITTER_NAME="$NEW_NAME"
  export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]; then
  export GIT_AUTHOR_NAME="$NEW_NAME"
  export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
