#!/bin/bash

echo "🚀 개발 환경 자동 구축을 시작합니다..."

# 1. 필수 패키지 설치 (Ubuntu/WSL 기준)
echo "📦 필수 패키지 설치 중..."
sudo apt update
sudo apt install -y git vim-gtk3 curl zsh fzf ripgrep bat btop ncdu jq tldr tmux

# 2. Oh My Zsh 설치 (없을 경우만)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🎨 Oh My Zsh 설치 중..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Zsh 플러그인 & 테마 설치
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Powerlevel10k 테마
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# 4. Vim Plug (플러그인 매니저) 설치
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 5. Lazygit 설치 (최신 버전)
echo "zzz Lazygit 설치 중..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit

# 6. 설정 파일 심볼릭 링크 연결 (핵심!)
echo "🔗 설정 파일 연결 중..."
ln -sf ~/linux_settings/.zshrc ~/.zshrc
ln -sf ~/linux_settings/.vimrc ~/.vimrc
ln -sf ~/linux_settings/.p10k.zsh ~/.p10k.zsh
# ln -sf ~/linux_settings/.tmux.conf ~/.tmux.conf

# 7. Vim 플러그인 자동 설치
vim +PlugInstall +qall

echo "✅ 모든 설치가 완료되었습니다! zsh를 실행하세요."
echo "👉 source ~/.zshrc"

