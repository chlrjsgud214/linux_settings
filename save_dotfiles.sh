#!/bin/bash

# --- 설정 ---
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_ROOT="$DOTFILES_DIR/back"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$BACKUP_ROOT/$TIMESTAMP"
FILES=(" .zshrc" ".vimrc" ".p10k.zsh" ) # 관리할 파일 목록 (띄어쓰기로 구분)

# --- 시작 ---
echo "🚀 설정 백업 및 Git 업로드를 시작합니다..."

# 1. 백업 폴더 생성 (dotfiles/back/20260109_120000)
mkdir -p "$BACKUP_DIR"
echo "📂 현재 설정을 백업 폴더에 저장 중... ($BACKUP_DIR)"

# 2. 파일 복사 및 동기화
for FILE in "${FILES[@]}"; do
    SOURCE="$HOME/$FILE"
    TARGET="$DOTFILES_DIR/$FILE"
    BACKUP="$BACKUP_DIR/$FILE"

    if [ -f "$SOURCE" ]; then
        # (1) 현재 상태를 back 폴더에 스냅샷 저장 (심볼릭 링크면 원본을 따라가서 내용 복사)
        cp -L "$SOURCE" "$BACKUP"
        
        # (2) dotfiles 메인 폴더로도 최신 내용 복사 (이미 링크되어 있어도 안전하게 덮어쓰기)
        cp -L "$SOURCE" "$TARGET"
    else
        echo "⚠️  [주의] $FILE 파일이 없어 건너뜁니다."
    fi
done

# 3. Git 업로드
echo "☁️  GitHub에 업로드를 시작합니다..."
cd "$DOTFILES_DIR"

# 변경사항이 있는지 확인
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update settings: $TIMESTAMP"
    git push
    echo "✅ 성공적으로 업로드되었습니다!"
else
    echo "ℹ️  변경 사항이 없어 업로드하지 않았습니다."
fi

echo "🎉 모든 작업 완료! (백업 위치: $BACKUP_DIR)"
