# Awesome Window Manager Configuration for MacBook Air 2017

This configuration is tailored specifically for the MacBook Air 2017, focusing on usability, hardware support, and a smooth desktop experience. It includes custom widgets and keybindings for brightness, keyboard backlight, audio, Bluetooth, and network management.

## Dependencies

### Core Packages
- `awesome`: The window manager itself
- `lua`: Programming language used by Awesome
- `luarocks`: Lua package manager

### Essential Utilities
- `rofi` or `dmenu`: Application launcher
- `picom`: Compositor for transparency and effects
- `feh`: Wallpaper setter and image viewer
- `scrot`: Screenshot utility
- `xclip`: Clipboard manager

### Audio
- `pulseaudio` or `pipewire-pulse`: Audio server
- `pavucontrol`: Audio control UI
- `alsa-utils`: For `amixer` and XF86 media keys support

### Bluetooth
- `bluez`: Bluetooth protocol stack
- `bluez-utils`: Bluetooth utilities
- `blueman`: Bluetooth manager with GTK UI

### Network
- `networkmanager`: Network connection manager
- `network-manager-applet`: Network management tray icon

### Brightness and Keyboard Backlight
- `light`: Backlight controller (screen brightness)
- `xorg-xbacklight`: Alternative for screen brightness
- `kbdlight` (AUR): Keyboard backlight control for MacBook
- `macbook-lighter` (AUR): Alternative keyboard backlight tool

### Other
- `xbindkeys`: For custom keybindings (optional)
- `xorg-xev`: For key event testing (optional)

## Installation (Arch Linux)

```bash

# Install Necessary Codecs
sudo pacman -S \
    ffmpeg \
    gst-libav \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \
    libva-utils \
    libvdpau-va-gl

# For Intel GPUs (Hardware Decoding)
sudo pacman -S intel-media-sdk libva-intel-driver

# Bonus: MPV for Smooth Local Playback
sudo pacman -S mpv
mpv --hwdec=vaapi --vo=gpu https://youtu.be/dQw4w9WgXcQ

# Install core components
sudo pacman -S awesome lua luarocks

# Install essential utilities
sudo pacman -S rofi picom feh scrot xclip

# Install audio packages
sudo pacman -S pulseaudio pavucontrol alsa-utils

# Install bluetooth packages
sudo pacman -S bluez bluez-utils blueman

# Install network management
sudo pacman -S networkmanager network-manager-applet

# Install brightness control
sudo pacman -S light xorg-xbacklight

# For MacBook keyboard backlight (AUR)
yay -S kbdlight macbook-lighter

# Optional: Install keybinds manager and key event tester
sudo pacman -S xbindkeys xorg-xev

# Enable and start required services
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

# Add your user to the video group for brightness control
sudo gpasswd -a $USER video
```

Log out and log back in for group changes to take effect.

## Usability Notes for MacBook Air 2017

- Brightness keys (F1/F2) and keyboard backlight keys (F5/F6) are mapped to control screen and keyboard brightness
- Volume keys (F10/F11/F12) are mapped for audio control via amixer or pulseaudio
- Bluetooth and Wi-Fi widgets are included for quick access and status display
- Custom keybindings are optimized for the MacBook Air keyboard layout
- The configuration handles Mac-specific hardware quirks automatically

## Features

- Full support for MacBook Air 2017 hardware keys
- Custom widgets for battery, audio, brightness, Bluetooth, and Wi-Fi
- Easy network and Bluetooth management from the system tray
- Fast application launching with rofi or dmenu
- Compositor and wallpaper support for a modern look
- Screenshot and clipboard utilities integrated
- Power management optimizations for improved battery life

## Troubleshooting

- If brightness or keyboard backlight controls do not work, ensure your user is in the video group and that kbdlight and light are installed correctly
- For Bluetooth issues, verify the bluetooth service is running with `systemctl status bluetooth`
- If widgets do not appear, check for missing dependencies or configuration errors
- For issues with function keys, ensure that fn key behavior is properly configured in your kernel parameters

## License

MIT