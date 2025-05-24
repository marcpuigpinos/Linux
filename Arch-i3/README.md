# Arch Linux installation


## Set the keymap

Boot to the live system in the usb and write:

```bash
localectl set-keymap es
```


## Internet

Before launching the assistant we need to be connected to the internet. Ethernet connection is resolved automatically but for wireless we need to specify the SSID and the password.

### Ethernet

Just connect the cable.

### Wifi

```bash
iwctl
```

```iwctl
[iwd] # device list
```
This will show a list with all the wireless devices. Usually *wlan0*. Let's say the device is named *wlan0*.

```iwctl
[iwd] # station wlan0 scan
[iwd] # station wlan0 get-networks
```
This will scan and show all the SSID of the wireless networks around. Let's say the SSID is WIRELESS-CONN-1

```iwctl
[iwd] # station name connect WIRELESS-CONN-1
```
It will ask for the password, and after enter it, the connecton will be established.

More information can be found <a href="https://wiki.archlinux.org/title/Iwd#iwctl">here</a>.

### Mobile connection

Check this <a href="https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager">link</a>.


## Launch the assistan

```bash
archinstall
```

Follow the instructions.


# Post installation

## Install web browser and 7zip.

Install Firefox and 7zip.

```bash
sudo pacman -S firefox p7zip
```

## Scripts

1. Give execution permissions to all scripts.
```bash
chmod +x *.sh
```

2. To run script 1 you need to be superuser, as it installs all the software.

```bash
sudo ./01_installation.sh
``` 

3. The other scripts can be run without superuser privilages.

```bash
./02_installation.sh
./03_installation.sh
```

# Some problems ...

## Windows not detected by grub

If grub does not show Windows bootloader, we need to do the following.

1. Install *os-prober* and grub.

```bash
sudo pacman -S os-prober
sudo pacman -S grub
```

2. Run os-prober and check that Windows bootloader is found.

```bash
sudo os-prober
```

3. Uncomment the variable *GRUB_DISABLE_OS_PROBER* from the grub configuration file at */etc/default/grub*.

```bash
vim /etc/default/grub
```

Remove the *#* to uncomment.

```bash
GRUB_DISABLE_OS_PROBER=false
```

Then run the following command and then reboot.

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

That's it. You should see Windows under the grub menu. If this is not working try the following.

```bash
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```


## Laptops Power Management

Download from <a href="https://github.com/rickysarraf/laptop-mode-tools">here</a> and install following the instructions. Install *PyQt5* to run the GUI.

```bash
sudo pacman -S python-pyqt5
```

Run the GUI by using the following command.

```bash
lmt-ui
```

# Links of interest

- https://wiki.archlinux.org/title/Installation_guide
