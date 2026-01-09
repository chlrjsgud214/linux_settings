#!/bin/bash

# --- 설정 ---
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_ROOT="$DOTFILES_DIR/back"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$BACKUP_ROOT/$TIMESTAMP"
# 관리할 파일 목록
FILES=(".zshrc" ".vimrc" ".p10k.zsh" "install.sh" "save_dotfiles.sh")

# --- 시작 ---
echo "🚀 설정 백업 및 Git 업로드를 시작합니다..."

# 0. Git 최신 상태 받아오기 (Pull) - 에러 방지 핵심!
cd "$DOTFILES_DIR"
echo "⬇️  GitHub에서 최신 변경사항을 가져옵니다..."
if git pull origin main; then
    echo "✅ 동기화 완료"
else
    echo "⚠️  동기화 중 충돌 발생! 수동 해결이 필요할 수 있습니다."
    # 치명적이지 않으므로 계속 진행하거나 여기서 exit 1 할 수 있음
fi

# 1. 백업 폴더 생성
mkdir -p "$BACKUP_DIR"

# 2. 파일 복사 및 동기화
for FILE in "${FILES[@]}"; do
    SOURCE="$HOME/$FILE"
    TARGET="$DOTFILES_DIR/$FILE"
    BACKUP="$BACKUP_DIR/$FILE"

    if [ -f "$SOURCE" ]; then
        # 백업 및 덮어쓰기
        cp -L "$SOURCE" "$BACKUP"
        cp -L "$SOURCE" "$TARGET"
    fi
done

echo "📂 현재 설정 백업 완료: back/$TIMESTAMP/"

# 3. Git 업로드 (에러 체크 추가)
echo "☁️  GitHub에 업로드를 시작합니다..."

# 변경사항 확인
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update settings: $TIMESTAMP"
    
    # Push 성공 여부 체크
    if git push origin main; then
        echo "✅ 성공적으로 업로드되었습니다!"
    else
        echo "❌ 업로드 실패! (위의 에러 메시지를 확인하세요)"
        exit 1
    fi
else
    echo "ℹ️  변경 사항이 없어 업로드하지 않았습니다."
fi
