#!/bin/zsh

echo "Upgrading system packages..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common libssl-dev libffi-dev git wget nano

echo "Upgrading go..."
GO_VERSION=1.14.3
if [[ -d /usr/local/go ]] ; then
    # Todo: better update logic
    sudo rm -rf /usr/local/go
fi

curl -sSL https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

echo "Upgrading dotnet..."
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current && \
    mkdir -p ~/bin

if [[ ! -L $HOME/bin/dotnet ]] ; then
    sudo ln -s ~/.dotnet/dotnet ~/bin/dotnet
fi

echo "Upgrading nvm..."
NVM_DIR="$HOME/.nvm"
if [[ -d $NVM_DIR ]] ; then 
    rm -rf $NVM_DIR
fi
(
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
nvm install node

echo "Install kubectl Repo..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Updating and cleaning packages"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "Installing kubectl"
sudo apt-get install -y kubectl