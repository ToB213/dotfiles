" プラグイン管理
call plug#begin()

" vim-goプラグインのインストールとバイナリインストール
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" coc.nvimプラグインのインストール
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ultisnipsプラグインのインストール
Plug 'SirVer/ultisnips'

" splitjoinプラグインのインストール
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

" ファイル編集時に自動保存を有効にする
set autowrite

" ターミナルの色数を256色に設定
set t_Co=256

" 行番号を表示する
set number

" エンコード
set enc=utf-8

" Return で補完の決定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" vim-goのエラー/警告表示にQuickfixリストを使用する
let g:go_list_type = "quickfix"

" リーダーキーをスペースキーに設定
let mapleader = "\<space>"

" Quickfixリスト操作のショートカット
" Ctrl+nで次のQuickfix項目に移動
map <C-n> :cnext<CR>
" Ctrl+mで前のQuickfix項目に移動
map <C-m> :cprevious<CR>
" リーダーキー + a でQuickfixウィンドウを閉じる
nnoremap <leader>a :cclose<CR>

" Go言語関連のショートカット
" Goファイルの編集時
autocmd FileType go 
    " リーダーキー + r で go run コマンドを実行
    nmap <leader>r <Plug>(go-run)
    " リーダーキー + t で go test コマンドを実行
    nmap <leader>t <Plug>(go-test)

" Goファイルの種類に応じてビルドまたはテストを行う関数
function! s:build_go_files()
    let l:file = expand('%')
    
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd FileType go 
    " リーダーキー + b で Goファイルの種類に応じたビルド/テスト関数を実行
    nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
