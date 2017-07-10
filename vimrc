set autoindent
set number


set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set nocompatible
set whichwrap=b,s,<,>,[,]


"===========================================
"キーマッピング
"===========================================
inoremap <C-c> <Esc>
imap <C-e> <END>
imap <C-a> <HOME>
inoremap <C-b> b
inoremap <C-w> w
inoremap <C-j>  <down>
inoremap <C-k>  <up>
inoremap <C-h>  <left>
inoremap <C-l>  <right>


nnoremap == gg=G    "=を二回連続入力でバッファ全体をインデント整理

set list
set listchars=tab:»-,trail:-,nbsp:-
nnoremap <silent><C-t> :NERDTreeToggle<CR>

"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


" Tab系
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=4
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan


"----------------------------------------------------------
"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
NeoBundle 'tomasr/molokai' 

NeoBundle 'thinca/vim-quickrun'
if neobundle#tap('vim-quickrun') "{{{
                    \ 'java' : {
                    \ 'hook/output_encode/enable' : 1,
                    \ 'hook/output_encode/encoding' : 'utf-8',
                    \ }
endif "}}}
" NERDTreeを設定                  <----- 追記
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete.vim'

call neobundle#end()
 
" Required:
filetype plugin indent on
 
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------a
"
syntax on 
colorscheme molokai

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><C-i>     neocomplete#complete_common_string()
