# 1. 내 설정 저장소 가져오기
git clone https://github.com/chlrjsgud214/linux_settings.git

# 2. 폴더로 이동
cd ~/linux_settings

# 3. 설치 스크립트 실행
./install.sh

## 1. 자격 증명을 파일에 영구적으로 저장하도록 설정
git config --global credential.helper store

# 2. 한 번만 더 입력하세요 (이후에는 묻지 않습니다)
git push origin main
# Username: [내 아이디]
# Password: [발급받은 GitHub Token]
