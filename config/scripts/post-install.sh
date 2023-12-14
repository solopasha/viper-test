#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!

# Tell build process to exit if there are any errors.
set -oue pipefail

# set sddm as default
systemctl set-default graphical.target 

# latest distrobox
#curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh


