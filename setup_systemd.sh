curl -sSL https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg | sudo apt-key add - 

sudo tee -a /etc/apt/sources.list.d/wsl-transdebian.list <<LIST
deb https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
deb-src https://arkane-systems.github.io/wsl-transdebian/apt/ $(lsb_release -cs) main
LIST

sudo apt-get update -qq
sudo apt install -yqq systemd-genie

sudo tee /etc/genie.ini <<CONF
[genie]
secure-path=/lib/systemd:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
unshare=/usr/bin/unshare
update-hostname=false
clone-path=false
clone-env=WSL_DISTRO_NAME,WSL_INTEROP,WSLENV,DISPLAY,WAYLAND_DISPLAY,PULSE_SERVER
systemd-timeout=60
CONF