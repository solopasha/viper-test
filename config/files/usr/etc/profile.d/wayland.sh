# Set XDG_CURRENT_DESKTOP to sway (for screencasting and screensharing capabilities)
#export XDG_CURRENT_DESKTOP=sway
#export XDG_SESSION_DESKTOP=sway

export XDG_SESSION_TYPE=wayland

# Ubuntu Sway specific config dir
export XDG_CONFIG_DIRS=/etc/xdg

# Force Wayland for Mozilla Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1

# Force Wayland for Qt apps
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt5ct

# Force Wayland for EFL (Enlightenment) apps
export ECORE_EVAS_ENGINE="wayland-egl"
export ELM_ACCEL="gl"

# Java XWayland blank screens fix
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
export BEMENU_BACKEND=wayland


# Check if system is running in virtual machines
case "$(systemd-detect-virt)" in
qemu)
  export WLR_RENDERER=pixman
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
kvm)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
oracle)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
vmware)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
none)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
esac

# Apply Nvidia-specific variables
CHK_DRV=$(lspci -k | grep -A 2 -i "VGA" | awk 'NR==3' | awk -F: '{ print $2 }' | sed 's/^[ \t]*//g')

if [ "$CHK_DRV" = "nvidia" ]; then
    export LIBVA_DRIVER_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
fi

if lspci -k | grep "Kernel driver in use" | grep nouveau; then 
  export WLR_NO_HARDWARE_CURSORS=1
fi
