# Linux

Linux scripts, configurations and useful information.

## Fedora I3wm spin

### Customization

This works for **SPANISH** installation of **Fedora I3wm** spin.
Give execution permission to both scripts.

```console
chmod +x 01_configure_fedora_sudo.sh
chmod +x 02_configure_fedora.sh
```

Execute first script as superuser.

```console
sudo ./01_configure_fedora_sudo.sh
```

Execute second script (not as superuser).

```console
sh 02_configure_fedora.sh
```

### I3wm shortcuts

Main personal shortcuts:

- Mod key: win
- Open VS Code: $mod + c
- Open Firefox: $mod + n
- Open Terminology: $mod + enter
- Open Rofi: $mod + d
- Open Rofi-Wiffi: $mod + x

Other shortcuts are I3wm usual shortcuts. Reference: https://i3wm.org/docs/refcard.html
