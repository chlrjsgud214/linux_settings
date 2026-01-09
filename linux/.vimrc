call plug#begin()
    Plug 'liuchengxu/vim-which-key' " ★ 단축키 도우미 플러그인
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set background=dark
colorscheme pablo

" --- ★ Which-Key 설정 (여기부터 추가하세요) ---
" 1. 리더키(메인 단축키)를 스페이스바로 설정
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" 2. 스페이스바를 누르면 which-key 메뉴가 뜨도록 연결
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

"--- 내 단축키 정의 ---
" --- 윈도우 친화적 단축키 설정 (Ctrl+A, C, V, Z) ---

" 1. Ctrl+A : 전체 선택 (모든 모드)
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG
vnoremap <C-a> <Esc>ggVG

" 2. Ctrl+C : 복사 (비주얼 모드에서 선택 후)
" 주의: 시스템 클립보드(+)로 복사합니다.
vnoremap <C-c> "+y

" 3. Ctrl+V : 붙여넣기
" 일반 모드에서 붙여넣기
nnoremap <C-v> "+p
" 입력 모드(i)에서 붙여넣기 (Ctrl+r, + 조합)
inoremap <C-v> <C-r>+
" 비주얼 모드에서 선택된 텍스트를 덮어쓰며 붙여넣기
vnoremap <C-v> "+p

" 4. Ctrl+Z : 실행 취소 (Undo)
" 원래 Vim의 Ctrl+z(백그라운드 전환) 기능을 덮어씁니다.
nnoremap <C-z> u
inoremap <C-z> <C-o>u

" --- Ctrl + X : 잘라내기 (Cut) ---

" 1. Normal 모드: 현재 줄을 통째로 잘라내기 (시스템 클립보드로)
nnoremap <C-x> "+dd

" 2. Visual 모드: 드래그 선택한 영역만 잘라내기
vnoremap <C-x> "+d

" 3. Insert(입력) 모드: 입력 도중 현재 줄 삭제하기
" (주의: Vim의 자동완성 단축키 기능을 덮어씁니다)
inoremap <C-x> <Esc>"+ddi

" --- Shift + 방향키로 범위 선택 (GUI 스타일) ---

" 1. Normal 모드에서 Shift+방향키 누르면 -> 비주얼 모드 진입 후 이동
nnoremap <S-Home> v<Home>
nnoremap <S-End> v<End>
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>

" 2. Visual 모드에서 Shift+방향키 누르면 -> 범위 확장 (그냥 이동해도 확장됨)
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>

" 3. Insert(입력) 모드에서 Shift+방향키 누르면 -> 즉시 비주얼 모드로 전환하여 선택
inoremap <S-Up> <Esc>v<Up>
inoremap <S-Down> <Esc>v<Down>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc>v<Right>

nnoremap <leader>z :
" 스페이스바 + w = 저장
nnoremap <leader>w :w<CR>
" 스페이스바 + q = 종료 (저장X)
nnoremap <leader>q :q!<CR>
" 스페이스바 + x = 저장하고 종료
nnoremap <leader>x :wq<CR>
" 스페이스바 + v = .vimrc 설정파일 열기 (바로 수정 가능)
nnoremap <leader>v :e $MYVIMRC<CR>
" 스페이스바 + r = .vimrc 설정 새로고침
nnoremap <leader>r :source $MYVIMRC<CR>
" --- coc.nvim (자동완성) Tab키 설정 ---

" 1. Tab을 누르면 자동완성 메뉴 이동 (팝업이 떠 있을 때)
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" 2. Shift+Tab을 누르면 뒤로 이동
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 3. Enter를 누르면 선택된 자동완성 적용
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 백스페이스 체크 함수 (필수)
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 3. 메뉴가 뜨는 시간 (기본값은 1초, 답답하면 500 등으로 줄이세요)
set timeoutlen=500

" --- Basic UI ---
set number          " 줄 번호 표시
set cursorline      " 현재 커서가 있는 줄 강조
set showmatch       " 괄호 짝 () {} [] 하이라이트

" --- Coding ---
syntax on           " 문법 강조 (색상)
set autoindent      " 자동 들여쓰기
set cindent         " C언어 스타일 들여쓰기 (임베디드 개발 시 유용)
set tabstop=4       " 탭 간격 4칸
set shiftwidth=4    " 자동 들여쓰기 간격 4칸
set expandtab       " 탭을 스페이스로 변환 (호환성 추천)

" --- Search ---
set ignorecase      " 검색 시 대소문자 무시
set hlsearch        " 검색 결과 하이라이트
colorscheme gruvbox  " 혹은 slate, pablo 등 마음에 드는 테마
