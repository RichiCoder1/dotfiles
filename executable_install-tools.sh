#!/bin/zsh

echo "Upgrading system packages..."
sudo apt-get update -qq
sudo apt-get install -yqq apt-transport-https ca-certificates curl software-properties-common libssl-dev libffi-dev git wget nano gpg

echo "Upgrading dotnet..."
curl -sSL -o- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o- | sudo apt-key add -
sudo curl -sSL https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list -o /etc/apt/sources.list.d/microsoft-prod.list 
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

sudo apt-get update -qq
sudo apt-get install dotnet-sdk-3.1 -yqq

echo "Upgrading go..."
GO_VERSION=1.14.3
if [[ -d /usr/local/go ]] ; then
    # Todo: better update logic
    sudo rm -rf /usr/local/go
fi

curl -sSL https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

echo "Upgrading nvm..."
NVM_DIR="$HOME/.nvm"
if [[ -d $NVM_DIR ]] ; then 
    rm -rf $NVM_DIR
fi
(
  git clone -q https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` -q
) && \. "$NVM_DIR/nvm.sh"
nvm install node

echo "Install kubectl repo..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Updating and cleaning packages"
sudo apt-get update -qq
sudo apt-get upgrade -yqq
sudo apt-get autoremove -yqq

echo "Installing kubectl"
sudo apt-get install -yqq kubectl

echo "Installing Homebrew"
yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"