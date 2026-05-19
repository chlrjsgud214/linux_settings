#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

APT_PACKAGES=(
  git
  zsh
  curl
  wget
  unzip
  fontconfig
  fonts-nanum
  vim-gtk3
  neovim
  fzf
  ripgrep
  bat
  btop
  ncdu
  jq
  tldr
  tmux
  linux-tools-virtual
  hwdata
)

echo "개발용 zsh 환경 설치를 시작합니다."

echo "[1/6] apt 패키지 설치"
sudo apt update
sudo apt install -y "${APT_PACKAGES[@]}"

echo "[2/6] Oh My Zsh 설치"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh가 이미 설치되어 있습니다."
fi

echo "[3/6] zsh 플러그인 및 Powerlevel10k 설치"
mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

echo "[4/6] Vim Plug 설치"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "[5/6] lazygit 설치"
case "$(uname -m)" in
  x86_64) LAZYGIT_ARCH="x86_64" ;;
  aarch64|arm64) LAZYGIT_ARCH="arm64" ;;
  *)
    echo "지원하지 않는 lazygit 아키텍처입니다: $(uname -m)"
    LAZYGIT_ARCH=""
    ;;
esac

if [ -n "$LAZYGIT_ARCH" ]; then
  LAZYGIT_VERSION="$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')"
  curl -Lo /tmp/lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"
  tar -C /tmp -xf /tmp/lazygit.tar.gz lazygit
  sudo install /tmp/lazygit /usr/local/bin/lazygit
  rm -f /tmp/lazygit.tar.gz /tmp/lazygit
fi

echo "[6/6] dotfile 심볼릭 링크 연결"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

if command -v vim >/dev/null 2>&1; then
  vim +PlugInstall +qall
fi

echo "설치가 완료되었습니다."
echo "zsh를 기본 쉘로 쓰려면 필요 시 실행: chsh -s $(command -v zsh)"
echo "현재 터미널에 적용: source ~/.zshrc"
