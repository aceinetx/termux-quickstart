#!/bin/bash

package_manager="apt"
use_sudo="0"

setup_nvim="0"
setup_langs="0"
setup_omz="0"

while [[ true ]]; do

clear

printf "\x1b[38;5;178m"
printf "    _______                              ____        _      _        _             _   \n"
printf "   |__   __|                            / __ \\      (_)    | |      | |           | |  \n"
printf "\x1b[38;5;179m"
printf "      | | ___ _ __ _ __ ___  _   ___  _| |  | |_   _ _  ___| | _____| |_ __ _ _ __| |_ \n"
printf "      | |/ _ \\ '__| '_ \` _ \\| | | \\ \\/ / |  | | | | | |/ __| |/ / __| __/ _\` | '__| __|\n"
printf "\x1b[38;5;180m"
printf "      | |  __/ |  | | | | | | |_| |>  <| |__| | |_| | | (__|   <\\__ \\ || (_| | |  | |_ \n"
printf "      |_|\\___|_|  |_| |_| |_|\\__,_/_/\\_\\___\\_\\ __,_|_|\\ ___|_|\\_\\___/\\__\\__,_|_|   \\__|\n"
printf "\x1b[38;5;15m\n"

printf "Welcome to termux-quickstart! Here you can easily configure your termux from scratch.\n"
printf "Made by aceinet\n"

printf "\nPackage manager configuration: \n"
printf "package manager: $package_manager\n"
printf "use sudo: "
if [[ "$use_sudo" == "1" ]]; then
  printf "yes"
else
  printf "no"
fi
printf "\n"

printf "\n(1) "
if [[ "$setup_nvim" == "1" ]]; then
  printf "[x] "
else
  printf "[ ] " 
fi
printf "Neovim with lsp and nvchad"

printf "\n(2) "
if [[ "$setup_langs" == "1" ]]; then
  printf "[x] "
else
  printf "[ ] " 
fi
printf "Compilers/interpreters for many popular languages"

printf "\n(3) "
if [[ "$setup_omz" == "1" ]]; then
  printf "[x] "
else
  printf "[ ] " 
fi
printf "Oh-my-zsh"

printf "\n\nq - exit\n"
printf "c - begin setup\n"
printf "s - use sudo\n"
printf "p - switch package manager"

input=""
printf "\n\nSelect what you need: "
read -n1 input

if [[ "$input" == "p" ]]; then
  if [[ "$package_manager" == "apt" ]]; then
    package_manager="pkg"
  else
    package_manager="apt"
  fi
fi

if [[ "$input" == "s" ]]; then
  if [[ "$use_sudo" == "1" ]]; then
    use_sudo="0"
  else
    use_sudo="1"
  fi
fi

if [[ "$input" == "1" ]]; then
  if [[ "$setup_nvim" == "0" ]]; then
    setup_nvim="1"
  else
    setup_nvim="0"
  fi
fi

if [[ "$input" == "2" ]]; then
  if [[ "$setup_langs" == "0" ]]; then
    setup_langs="1"
  else
    setup_langs="0"
  fi
fi

if [[ "$input" == "3" ]]; then
  if [[ "$setup_omz" == "0" ]]; then
    setup_omz="1"
  else
    setup_omz="0"
  fi
fi


if [[ "$input" == "q" ]]; then
  clear
  break
fi

if [[ "$input" == "c" ]]; then
  printf "\n"
  sudo_cmd=""
  if [[ "$use_sudo" == "1" ]]; then
    sudo_cmd="sudo"
  fi

  if [[ "$setup_nvim" == "1" ]]; then
    printf "\x1b[38;5;178mo Downloading neovim and lsp servers\x1b[38;5;15m\n"
    $sudo_cmd $package_manager update
    $sudo_cmd $package_manager install neovim clang -y
    printf "\x1b[38;5;178mo Downloading neovim config\x1b[38;5;15m\n"
    mkdir -p $HOME/.config
    wget https://188.242.58.203:8443/nvimcfg.tar.gz --no-check-certificate
    printf "\x1b[38;5;178mo Unpacking config\x1b[38;5;15m\n"
    rm -rf $HOME/.config/nvim
    tar -xvf nvimcfg.tar.gz
    mv nvim $HOME/.config
  fi

  if [[ "$setup_langs" == "1" ]]; then
    printf "\x1b[38;5;178mo Setting up compilers/interpreters\x1b[38;5;15m\n"
    $sudo_cmd $package_manager update
    $sudo_cmd $package_manager install gcc clang python nodejs -y
  fi

  if [[ "$setup_omz" == "1" ]]; then
    printf "\x1b[38;5;178mo Setting up oh-my-zsh\x1b[38;5;15m\n"
    $sudo_cmd $package_manager update
    $sudo_cmd $package_manager install zsh git -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  printf "\n\n"

  printf "Setup finished!\n"
  printf "Press any key to continue..."
  read -n1 k
fi

done
