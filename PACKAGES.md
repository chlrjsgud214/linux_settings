# 설치 패키지 정리

## apt 패키지

| 패키지 | 용도 |
| --- | --- |
| `git` | 저장소 관리 |
| `zsh` | 기본 쉘 |
| `curl`, `wget` | 설치 파일/API 다운로드 |
| `unzip` | 압축 해제 |
| `fontconfig`, `fonts-nanum` | 폰트 설정 및 한글 표시 |
| `vim-gtk3`, `neovim` | 편집기, 클립보드 연동, `vim` alias 대상 |
| `fzf` | 퍼지 검색 |
| `ripgrep` | 빠른 텍스트 검색 |
| `bat` | syntax highlight가 있는 `cat` 대체 도구 |
| `btop` | 시스템 모니터 |
| `ncdu` | 디스크 사용량 분석 |
| `jq` | JSON 처리 |
| `tldr` | 명령어 예시 문서 |
| `tmux` | 터미널 세션 관리 |
| `linux-tools-virtual`, `hwdata` | WSL2 USB 장치/카메라 연결 지원 |

## GitHub에서 설치

| 도구 | 설치 위치 | 용도 |
| --- | --- | --- |
| Oh My Zsh | `~/.oh-my-zsh` | zsh 설정 프레임워크 |
| `zsh-autosuggestions` | `$ZSH_CUSTOM/plugins` | 명령어 자동 제안 |
| `zsh-syntax-highlighting` | `$ZSH_CUSTOM/plugins` | 명령어 문법 하이라이트 |
| Powerlevel10k | `$ZSH_CUSTOM/themes` | zsh 프롬프트 테마 |
| Vim Plug | `~/.vim/autoload/plug.vim` | Vim/Neovim 플러그인 매니저 |
| lazygit | `/usr/local/bin/lazygit` | 터미널 Git UI |

## Python/AI Edge

`python_setup.sh`가 별도로 설치합니다.

| 항목 | 용도 |
| --- | --- |
| Miniconda | Python 가상환경 관리 |
| `ai_edge` conda env | AI Edge 개발 환경 |
| `numpy` | 수치 연산 |
| `opencv-python` | 이미지/카메라 처리 |
| `ultralytics` | YOLO 모델 |
| `rapidocr_onnxruntime` | OCR |
