# Arch Linux installation


## Set the keymap

Boot to the live system in the usb and write:

```bash
# localectl set-keymap es
```


## Internet

Before launching the assistant we need to be connected to the internet. Ethernet connection is resolved automatically but for wireless we need to specify the SSID and the password.

### Ethernet

Just connect the cable.

### Wifi

```bash
# iwctl
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
# archinstall
```
