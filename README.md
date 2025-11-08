# Setting up Arch Linux and i3wm

## Install Arch Linux

The full guide of how to install Arch Linux can be found in <a href="https://wiki.archlinux.org/title/Installation_guide"> Arch wiki</a>.

### Keymap

- Method 1:

```bash
loadkeys es
```

- Method 2:

```bash
localectl set-keymap es
```

### Internet

#### Ethernet

Nothing to do.

#### Wifi

How to use **iwctl** to connect to your Wifi is explained in this address:

- https://wiki.archlinux.org/title/Iwd#iwctl

In my case:

```bash
iwctl
```

```bash
[iwd] # device list
```

This will sh ow a list with all the wireless devices. In my case the device name is *wlan0*.

```bash
[iwd] # station wlan0 scan
[iwd] # station wlan0 get-networks
```

This will scan and show all the SSID of the wireless networks around. Let's say the SSID is WIRELESS-CONN-1.

```bash
[iwd] # station wlan0 connect WIRELESS-CONN-1
```

Write the password and check if the connection is established, doing ping to Google:

```bash
ping www.google.es
```

### Launch the assistant

```bash
archinstall
```

Follow the instructions and choose i3wm installation. In my case install PulseAudio no pipewhire, and use NetworkManager. At this stage is mandatory to install networkmanager and network-manager-applet. Also very useful to install Chromium.

## Install programs

All this programs can be installed during the installation process. They can also be installed after the first boot.

- chromium: browser.
- emacs: text editor.
- vim: terminal text editor.
- alacritty: terminal.
- git: version control.
- python-pip: python package manager.
- base-devel: install compilers, and make.
- gcc-gfortran: fortran compiler.
- cmake: build tool.
- meson: build tool.
- unzip
- 7zip
- xorg-xrandr: manage displays
- arandr: xrandr frontend.
- man-db: install manpages.
- xdg-user-dirs: install default user dirs of the system.
- networkmanager
- network-manager-applet: applet to use network manager.
- blueman: bluetooth.
- bluez: bluetooth.
- bluez-utils: bluetooth.
- brightnessctl : for laptop.
- pavucontrol: volume control.
- thunar: file manager.
- gvfs: virtual filesystem suport (needed for mounting via Thunar).
- xclip: clipboard.
- bat: cat but beautiful.
- fzf: fuzzy finder.
- btop: top but beautiful.
- feh: wallpaper.
- picom: lightweight X11 compositor (graphic effects, vsync).
- flameshot: screenshots.
- wget
- texlive: latex.
- exa: display icons when doing *ls*.
- os-prober: needed to configure grub and detect other systems if not detected by default.
- grub: needed to configure grub and detect other systems if not detected by default.

## First boot

### System wide actions

Update the system:

```bash
sudo pacman -Syu
```

If programs are not installed, install them by using the command:

```bash
sudo pacman -S name-of-the-program
```

Example of a base installation:

```bash
sudo pacman -S emacs vim alacritty git python-pip base-devel gcc-fortran cmake meson unzip 7zip arandr man-db xdg-user-dirs blueman bluez bluez-utils pavucontrol thunar gvfs xclip bat fzf btop feh exa wget xorg-xrandr flameshot picom
```

Enable bluetooth:

```bash
sudo systemctl enable --now bluetooth
```

Create user directories:

```bash
xdg-user-dirs-update
```

Reboot:

```bash
reboot
```

### Install Oh-my-bash

```bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
```

### Install DaddyTimeMono Nerd Font

Create the folder fonts in *~/.local/share/fonts*:

```bash
mkdir -p ~/.local/share/fonts
```

Download the font from <a href="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DaddyTimeMono.zip">here</a>. Unzip the contents and copy them to *~/.local/share/fonts*.

### Bashrc

1. Change *OSH_THEME* to *rr*:

```bash
OSH_THEME="rr"
```

2. Alias for *exa*:

```bash
alias ls='exa -l --icons --group-directories-first -h --total-size'
```

Example of my .bashrc

```bash
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='~/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="rr"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")
# You can also specify the list from which a theme is randomly selected:
# OMB_THEME_RANDOM_CANDIDATES=("font" "powerline-light" "minimal")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# To enable/disable Spack environment information
# OMB_PROMPT_SHOW_SPACK_ENV=true  # enable
# OMB_PROMPT_SHOW_SPACK_ENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# If you want to reduce the initialization cost of the "tput" command to
# initialize color escape sequences, you can uncomment the following setting.
# This disables the use of the "tput" command, and the escape sequences are
# initialized to be the ANSI version:
#
#OMB_TERM_USE_TPUT=no

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

# If Typora is installed:
# export PATH="/usr/bin/Typora-linux-x64:$PATH"

alias ls='exa -l --icons --group-directories-first -h --total-size'

```

### Alacritty

Create in your home directory a file called *.alacritty.toml* if it does not exist yet. Write the following configuration:

```toml
[font]
size = 12.0

[font.bold]
family = "DaddyTimeMono Nerd Font"
style = "Bold"

[font.bold_italic]
family = "DaddyTimeMono Nerd Font"
style = "Bold Italic"

[font.italic]
family = "DaddyTimeMono Nerd Font"
style = "Italic"

[font.normal]
family = "DaddyTimeMono Nerd Font"
style = "Regular"

[font.offset]
x = 1
y = 5

[selection]
save_to_clipboard = true

[terminal.shell]
program = "/bin/bash"

[window]
decorations = "full"
decorations_theme_variant = "Dark"
dynamic_padding = true
opacity = 1.0

[window.padding]
x = 5
y = 5

[terminal]

```

### Gtk 3.0: Dark theme

Create folder *~/.config/gtk-3.0*:

```bash
mkdir ~/.config/gtk-3.0
```

Move to the recently created folder *gtk-3.0* and create two files, *bookmarks* and *settings.ini*

```bash
touch bookmarks
touch settings.ini
```

Leave *bookmarks* empty and write the following in *settings.ini*:

```toml
[Settings]
gtk-application-prefer-dark-theme=true
```

### Wallpapers

Create the folder *~/.config/wallpapers*:

```bash
mkdir ~/.config/wallpapers
```

Copy the wallpapers to this folder. In my case I only have a wallpaper called *lake-mountains-rocks-sunrise-daylight-scenery-illustration-6016x6016-3773.jpg*. 

To change the Wallpaper, we need only to go to the *i3wm* config file and search for the name of my wallpapers and change it. It is a *feh* command.

### Picom

Create the file to hold the configuration file for *Picom*:

```bash
mkdir .config/picom
touch .config/picom/picom.conf
```

Edit *picom.conf* file and write the following:

```yaml
backend = "glx";  # Usa OpenGL para mejor rendimiento
vsync = true;

glx-no-stencil = true;
glx-no-rebind-pixmap = true;
use-damage = true;

# Otras opciones útiles
refresh-rate = 0;           # 0 = autodetect
vsync-use-glfinish = false;
unredir-if-possible = false;  # Importante para que vsync funcione bien

# Transparencias (opcional)
shadow = false;
fading = false;
```

### i3 config file

Open the file *~/.config/i3/config* delete its contents and paste the following:

```bash
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:DaddyTimeMono Nerd Font 12

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Start XDG autostart .desktop files using dex. See also
# https://wiki.archlinux.org/index.php/XDG_Autostart
exec --no-startup-id dex --autostart --environment i3

# The combination of xss-lock, nm-applet and pactl is a popular choice, so
# they are included here as an example. Modify as you see fit.

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock -c 000000 --nofork
bindsym $mod+Mod1+l exec i3lock -c 000000

# NetworkManager is the most popular way to manage wireless networks on Linux,
# and nm-applet is a desktop environment-independent system tray GUI for it.
exec --no-startup-id nm-applet

# Blueman for bluetooth
exec --no-startup-id blueman-applet

# Set resolution at start
#exec xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --mode 2560x1440 --rate 144 -
#bindsym $mod+o exec xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output HDMI-1-0 --off --output DP-1-4 --off
#bindsym $mod+Shift+o exec xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output HDMI-1-0 --mode 1920x1080 --pos 2560x204 --rotate normal --output DP-1-4 --off

# Wallpaper
exec feh --bg-scale ~/.config/wallpapers/lake-mountains-rocks-sunrise-daylight-scenery-illustration-6016x6016-3773.jpg

# Picom: copositor
exec --no-startup-id picom --config ~/.config/picom/picom.conf

# Use pactl to adjust volume in PulseAudio.
set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# Brightness
#bindsym XF86MonBrightnessUp exec brightnessctl -d intel_backlight s +5% > /dev/null && notify-send Brightness $(($(brightnessctl get) * 10 / 937 * 10))% -h string:x-canonical-private-synchronous:brightness_percentage --app-name System
#bindsym XF86MonBrightnessDown exec brightnessctl -d intel_backlight s 5%- > /dev/null && notify-send Brightness $(($(brightnessctl get) * 10 / 937 * 10))% -h string:x-canonical-private-synchronous:brightness_percentage --app-name System


# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# move tiling windows via drag & drop by left-clicking into the title bar,
# or left-clicking anywhere into the window while holding the floating modifier.
tiling_drag modifier titlebar

# start a terminal
#bindsym $mod+Return exec i3-sensible-terminal
bindsym $mod+Return exec alacritty

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id dmenu_run -fn 'DaddyTimeMono Nerd Font:regular:pixelsize=20'
# A more modern dmenu replacement is rofi:
# bindcode $mod+40 exec "rofi -modi drun,run -show drun"
# There also is i3-dmenu-desktop which only displays applications shipping a
# .desktop file. It is a wrapper around dmenu, so you need that installed.
# bindcode $mod+40 exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+ntilde focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+ntilde move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# switch to workspace
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+5 workspace number $ws5
bindsym $mod+6 workspace number $ws6
bindsym $mod+7 workspace number $ws7
bindsym $mod+8 workspace number $ws8
bindsym $mod+9 workspace number $ws9
bindsym $mod+0 workspace number $ws10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym ntilde resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

bindsym $mod+r mode "resize"

bindsym $mod+b exec chromium
bindsym $mod+t exec thunar
bindsym $mod+c exec emacs

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3status
}
```

### i3status

Create the folder *i3status* if it does not exist and create a file called *config* inside:

```bash
mkdir ~/.config/i3status
touch ~/.config/i3status/config
```

Open the file config and paste the following:

```bash
general {
    output_format = "i3bar"
	colors = true
	color_good = "#a3be8c"
	color_degraded = "#ebcb8b"
	color_bad = "#bf616a"
	interval = 30
 	separator = "|"

}

order += "cpu_usage"
order += "disk /"
order += "disk /home"
order += "memory"
order += "ethernet enp12s0"
order += "wireless wlan0"
order += "battery all"
order += "volume master"
order += "tztime madrid"

cpu_usage {
	format = %usage
	degraded_threshold = 90
	max_threshold = 95
}

wireless wlan0 {
        format_up = "W: (%quality at %essid, %bitrate) %ip"
        format_down = "W: down"
}

ethernet enp12s0 {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

battery all {
        format = "%status %percentage %remaining %emptytime"
        format_down = "No battery"
        status_chr = "󰂈 CHR"
        status_bat = "󱊢 BAT"
        status_unk = "? UNK"
        status_full = "󱊣 FULL"
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
        last_full_capacity = true
}

volume master {
        format = "♪: %volume"
        format_muted = "♪: muted (%volume)"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
}

tztime madrid {
		format = "%Y-%m-%d %H:%M:%S"
		timezone = "Europe/Madrid"
}

memory {
        format = "%used/%total"
        threshold_degraded = "10%"
        format_degraded = "MEMORY: %free"
}

disk "/" {
        format = "%used/%total"
}

disk "/home" {
        format = "%used/%total"
}
```

### Emacs

#### Copilot

Download the Emacs plugin:
```
git clone https://github.com/copilot-emacs/copilot.el ~/.emacs.d/copilot
```

Download and install copilot cli.
```
npm -g --prefix ~/.emacs.d/.cache/copilot install @github/copilot-language-server
```

Open emacs and run:
```
M-x copilot-install-server
M-x copilot-login
```


### Reboot the system

```bash
reboot
```

