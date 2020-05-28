#!/bin/zsh

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
    mkdir -p ~/bin && \
    sudo ln -s ~/.dotnet/dotnet ~/bin/dotnet

echo "Upgrading nvm..."
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"