#!/bin/bash
folder=start
module_required=0

modules=()
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
    reset)
      command=reset
      shift
      ;;
    ycm)
      command=ycm
      shift
      ;;
    *)
      modules+=("$i")
      shift
      ;;
  esac
done

if [[ -z "$command" ]]; then
  echo "Either init, add, update, reset, ycm, or rm|remove needs to be specified"
  exit 1
elif [[ "${#modules[@]}" -eq 0 && $module_required -ne 0 ]]; then
  echo "A module must be defined when adding or removing."
  exit 1
fi

cd ~/

if [[ "$command" == "init" ]]; then
  echo "Initializing the packages and installing YouCompleteMe"
  git submodule update --init --recursive
  cd ~/.vim/pack/plugins/start/YouCompleteMe
  ./install.py --js-completer
  cd -
elif [[ "$command" == "reset" ]]; then
  echo "Reseting all submodules to commited version..."
  git submodule update --init --recursive
elif [[ "$command" == "update" ]]; then
  echo "Updating packages..."
  git submodule update --remote
elif [[ "$command" == "deinit" ]]; then
  for module in "${modules[@]}"; do
    echo "Removing package $module..."

    path=".vim/pack/plugins/$folder/$module"
    git submodule $command $path
    git rm -rf $path
    rm -Rf .git/modules/$path
  done
elif [[ "$command" == "ycm" ]]; then
  cd ~/.vim/pack/plugins/start/YouCompleteMe
  ./install.py --js-completer
  cd -
else
  echo "${modules[@]}"
  for module in "${modules[@]}"; do
    IFS='/' read -ra MODULE_SPLIT <<< "$module"
    module_name="${MODULE_SPLIT[1]}"

    echo "Adding package $module to '$folder/$module_name'"
    git submodule $command https://github.com/$module .vim/pack/plugins/$folder/$module_name
  done
fi

echo "Done!"
