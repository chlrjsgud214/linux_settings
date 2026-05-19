# linux_settings

Ubuntu/WSL 환경에서 쓰는 zsh 중심 개발 설정 저장소입니다.

## 빠른 설치

```bash
git clone https://github.com/chlrjsgud214/linux_settings.git ~/linux_settings
cd ~/linux_settings
chmod +x install.sh python_setup.sh save_settings.sh
./install.sh
source ~/.zshrc
```

AI Edge용 conda/python 환경까지 설치하려면 추가로 실행합니다.

```bash
./python_setup.sh
```

## 구성

- `.zshrc`: Oh My Zsh, Powerlevel10k, zsh 플러그인, Python venv 자동 활성화, conda alias
- `.p10k.zsh`: Powerlevel10k 프롬프트 설정
- `.vimrc`: Vim/Neovim 플러그인과 기본 단축키
- `install.sh`: zsh 환경과 필수 apt 패키지 설치
- `python_setup.sh`: Miniconda와 `ai_edge` conda 환경 설치
- `save_settings.sh`: 현재 홈 디렉토리 설정을 백업하고 Git에 업로드
- `PACKAGES.md`: 설치 패키지와 역할 정리

## Git 자격 증명 저장

```bash
git config --global credential.helper store
git push origin main
```

`Password`에는 GitHub 비밀번호가 아니라 Personal Access Token을 입력합니다.
