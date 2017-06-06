#!/bin/bash
set -e
folder=start
module_required=0

for i in "$@"; do
  case $i in
    -o|--optional)
      folder=opt
      shift
      ;;
    add)
      command=add
      module_required=1
      shift
      ;;
    rm|remove)
      command=deinit
      module_required=1
      shift
      ;;
    init)
      command=init
      shift
      ;;
    update)
      command=update
      shift
      ;;
    *)
      module=$i
      shift
      ;;
  esac
done

if [[ -z "$command" ]]; then
  echo "Either init, add, update, or rm|remove needs to be specified"
  exit 1
elif [[ -z "$module" && $module_required -ne 0 ]]; then
  echo "A module must be defined when adding or removing."
  exit 1
fi

cd ~/

if [[ "$command" == "init" ]]; then
  echo "Initializing the packages and installing YouCompleteMe"
  git submodule update --init --recursive
  cd ~/.vim/pack/plugins/start/YouCompleteMe
  ./install.py --tern-completer
  cd -
elif [[ "$command" == "update" ]]; then
  echo "Updating packages..."
  git submodule update --recursive --remote
else
  IFS='/' read -ra MODULE_SPLIT <<< "$module"
  module_name="${MODULE_SPLIT[1]}"

  echo "Adding package $module to $folder/$module_name"
  git submodule $command https://github.com/$module ~/.vim/pack/plugins/$folder/$module_name
fi
