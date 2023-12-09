#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Repository URL
REPO_URL="https://api.github.com/repos/JaKooLit/Hyprland-Dots"

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Function to print a note message
print_note() {
  printf "${NOTE} $1\n"
}

# Function to print a warning message
print_warn() {
  printf "${WARN} $1\n"
}

# Function to print a success message
print_ok() {
  printf "${OK} $1\n"
}

# Function to print an error message
print_error() {
  printf "${ERROR} $1\n"
}

# Function to check for the existence of Hyprland-Dots.tar.gz
check_existing_tarball() {
  if [ -f Hyprland-Dots.tar.gz ]; then
    print_note "Hyprland-Dots.tar.gz found."

    existing_version=$(echo Hyprland-Dots.tar.gz | grep -oP 'v\d+\.\d+\.\d+' | sed 's/v//')
    latest_version=$(curl -s "$REPO_URL/releases/latest" | grep "tag_name" | cut -d '"' -f 4 | sed 's/v//')

    if [ "$existing_version" = "$latest_version" ]; then
      print_ok "Hyprland-Dots.tar.gz is up-to-date with the latest release ($latest_version)."
      print_note "No update found. Sleeping for 10 seconds..."
      sleep 10
      exit 0
    else
      print_warn "Hyprland-Dots.tar.gz is outdated (Existing version: $existing_version, Latest version: $latest_version)."
      read -p "Do you want to upgrade to the latest version? (y/n): " upgrade_choice
      if [ "$upgrade_choice" = "y" ]; then
        print_note "Proceeding to download the latest release."
        find . -type d -name 'JaKooLit-Hyprland-Dots*' -exec rm -rf {} +
        rm -f Hyprland-Dots.tar.gz
        print_warn "Removed existing Hyprland-Dots.tar.gz."
      else
        print_note "User chose not to upgrade. Exiting..."
        exit 0
      fi
    fi
  fi
}

# Function to download the latest release of Hyprland-Dots
download_latest_release() {
  print_note "Downloading the latest Hyprland source code release..."

  latest_tag=$(curl -s "$REPO_URL/releases/latest" | grep "tag_name" | cut -d '"' -f 4)

  if [ -z "$latest_tag" ]; then
    print_error "Unable to fetch the latest tag information."
    exit 1
  fi

  latest_tarball_url=$(curl -s "$REPO_URL/releases/latest" | grep "tarball_url" | cut -d '"' -f 4)

  if [ -z "$latest_tarball_url" ]; then
    print_error "Unable to fetch the tarball URL for the latest release."
    exit 1
  fi

  file_name="Hyprland-Dots-${latest_tag}.tar.gz"

  if curl -L "$latest_tarball_url" -o "$file_name"; then
    tar -xzf "$file_name" || exit 1
    rm -rf JaKooLit-Hyprland-Dots

    extracted_directory=$(tar -tf "$file_name" | grep -o '^[^/]\+' | uniq)
    mv "$extracted_directory" JaKooLit-Hyprland-Dots || exit 1

    cd "JaKooLit-Hyprland-Dots" || exit 1
    chmod +x copy.sh
    ./copy.sh 2>&1 | tee -a "../install-$(date +'%d-%H%M%S')_dots.log"

    print_ok "Latest source code release downloaded, extracted, and processed successfully."
  else
    print_error "Failed to download the latest source code release."
    exit 1
  fi
}

# Main execution
print_note "Downloading / Checking for existing Hyprland-Dots.tar.gz..."
check_existing_tarball
download_latest_release

