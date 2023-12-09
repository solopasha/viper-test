#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"

printf "${NOTE} Copying contents of homedir to user's home directory...\n"

# Set the source directory
source_dir="/usr/etc/homedir"

# Get the current user's home directory
user_home_dir="$HOME"

# Check if the source directory exists
if [ -d "$source_dir" ]; then
  printf "${NOTE} Source directory found.\n"

  # Check if the user's home directory is available
  if [ -d "$user_home_dir" ]; then
    printf "${NOTE} User's home directory found.\n"

    # Copy the contents of homedir to the user's home directory
    cp -r "$source_dir"/* "$user_home_dir"/

    echo -e "${OK} Contents copied successfully."
  else
    echo -e "${ERROR} User's home directory not found."
    exit 1
  fi
else
  echo -e "${ERROR} Source directory not found."
  exit 1
fi

