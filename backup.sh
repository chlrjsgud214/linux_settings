#!/bin/bash

cd ~
mkdir -p dotfiles

# 1. 설정 파일들을 dotfiles 폴더로 이동
mv .zshrc dotfiles/
mv .vimrc dotfiles/
mv .p10k.zsh dotfiles/
# (tmux 설정도 있다면) mv .tmux.conf dotfiles/ 

# 2. 이동시킨 파일들을 원래 위치에 '바로가기(링크)'로 연결 (테스트)
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
