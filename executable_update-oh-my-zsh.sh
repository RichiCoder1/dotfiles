echo "Updating oh-my-zsh..."
curl -sSL -o oh-my-zsh-master.tar.gz https://github.com/robbyrussell/oh-my-zsh/archive/master.tar.gz
chezmoi import --strip-components 1 --destination ${HOME}/.oh-my-zsh oh-my-zsh-master.tar.gz
rm oh-my-zsh-master.tar.gz

echo "Updating powerlevel10k..."
curl -sSL -o powerlevel10k-master.tar.gz https://github.com/romkatv/powerlevel10k/archive/master.tar.gz
chezmoi import --strip-components 1 --destination ${HOME}/.oh-my-zsh/themes/powerlevel10k powerlevel10k-master.tar.gz
rm powerlevel10k-master.tar.gz
