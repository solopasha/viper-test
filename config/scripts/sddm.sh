printf " Activating sddm service........\n"
sudo systemctl set-default graphical.target 2>&1 | tee -a "$LOG"
sudo systemctl enable sddm.service 2>&1 | tee -a "$LOG"

# Set up SDDM
echo -e "${NOTE} Setting up the login screen."
sddm_conf_dir=/etc/sddm.conf.d
[ ! -d "$sddm_conf_dir" ] && { printf "$CAT - $sddm_conf_dir not found, creating...\n"; sudo mkdir -p "$sddm_conf_dir" 2>&1 | tee -a "$LOG"; }

wayland_sessions_dir=/usr/share/wayland-sessions
[ ! -d "$wayland_sessions_dir" ] && { printf "$CAT - $wayland_sessions_dir not found, creating...\n"; sudo mkdir -p "$wayland_sessions_dir" 2>&1 | tee -a "$LOG"; }
sudo cp assets/hyprland.desktop "$wayland_sessions_dir/" 2>&1 | tee -a "$LOG"

clear
    
  # SDDM-themes
    printf "\n%s - Installing Tokyo SDDM Theme\n" "${NOTE}"
    git clone https://github.com/rototrash/tokyo-night-sddm.git 2>&1 | tee -a "$LOG"
    sudo mv tokyo-night-sddm /usr/share/sddm/themes/
    echo -e "[Theme]\nCurrent=tokyo-night-sddm" | sudo tee -a "$sddm_conf_dir/10-theme.conf" 2>&1 | tee -a "$LOG"              		
  fi

clear
