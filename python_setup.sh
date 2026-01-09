#!/bin/bash

# ==========================================
# AI Edge 개발 환경 자동 구축 스크립트 (WSL2 + Zsh 전용)
# ==========================================

echo "🚀 설치를 시작합니다..."

# 1. 시스템 패키지 업데이트 및 필수 도구 설치
echo "📦 [1/5] 시스템 업데이트 및 필수 패키지 설치 중..."
sudo apt-get update -y
sudo apt-get install -y wget curl git unzip fontconfig
# USB 카메라 드라이버 및 한글 폰트
sudo apt-get install -y linux-tools-virtual hwdata fonts-nanum

# 2. Miniconda 설치 (이미 있으면 건너뜀)
CONDA_DIR="$HOME/miniconda3"
if [ ! -d "$CONDA_DIR" ]; then
    echo "🐍 [2/5] Miniconda 다운로드 및 설치 중..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -u -p "$CONDA_DIR"
    rm miniconda.sh
else
    echo "✅ Miniconda가 이미 설치되어 있습니다."
fi

# 3. Conda 초기화 (핵심: 사용자의 Shell이 Zsh인지 Bash인지 확인 후 적용)
echo "⚙️ [3/5] Shell 환경 설정 (Conda Init)..."
CURRENT_SHELL=$(basename "$SHELL")

if [ "$CURRENT_SHELL" = "zsh" ]; then
    echo "   👉 Zsh 환경이 감지되었습니다. 'conda init zsh'를 수행합니다."
    "$CONDA_DIR/bin/conda" init zsh
else
    echo "   👉 Bash 환경이 감지되었습니다. 'conda init bash'를 수행합니다."
    "$CONDA_DIR/bin/conda" init bash
fi

# 4. 가상환경 생성 및 라이브러리 설치
ENV_NAME="ai_edge"
echo "🛠️ [4/5] 가상환경('$ENV_NAME') 생성 및 라이브러리 설치..."

# Conda 명령어를 스크립트 내에서 쓰기 위해 일시적으로 소싱
source "$CONDA_DIR/etc/profile.d/conda.sh"

if conda info --envs | grep -q "$ENV_NAME"; then
    echo "   👉 이미 '$ENV_NAME' 환경이 존재합니다."
else
    conda create -n "$ENV_NAME" python=3.8 -y
fi

# 환경 활성화 및 패키지 설치
conda activate "$ENV_NAME"

echo "   📦 Python 패키지 설치 중 (YOLO, RapidOCR, OpenCV)..."
pip install --upgrade pip
# 핵심 라이브러리 (CPU/GPU 겸용)
pip install numpy opencv-python ultralytics rapidocr_onnxruntime

# GUI 에러 방지 (headless 제거)
pip uninstall opencv-python-headless -y
pip install opencv-python

# 5. 편의성 설정 (단축키 'ai' 등록)
echo "⌨️ [5/5] 단축키(Alias) 등록 중..."
TARGET_RC="$HOME/.zshrc"
if [ "$CURRENT_SHELL" = "bash" ]; then
    TARGET_RC="$HOME/.bashrc"
fi

# 이미 단축키가 있는지 확인 후 없으면 추가
if ! grep -q "alias ai=" "$TARGET_RC"; then
    echo "" >> "$TARGET_RC"
    echo "# AI Edge Environment Alias" >> "$TARGET_RC"
    echo "alias ai='conda activate $ENV_NAME'" >> "$TARGET_RC"
    echo "   ✅ 단축키 'ai'가 $TARGET_RC 에 등록되었습니다."
else
    echo "   ✅ 단축키 'ai'가 이미 존재합니다."
fi

echo "=========================================="
echo "🎉 모든 설치가 완료되었습니다!"
echo "👉 터미널을 껐다 켜거나, 다음 명령어를 입력하세요:"
echo "   source $TARGET_RC"
echo "👉 그 다음 'ai'를 입력하면 개발 환경이 실행됩니다."
echo "=========================================="
