nnoremap ; :
nnoremap : ;
set nocompatible
set number
set encoding=utf-8
set helplang=ja,en
set hlsearch
set cursorline
set noswapfile
set list
"ターミナルを画面下部に出す"
set splitbelow
"デフォルトのターミナルサイズ変更"
set termwinsize=20x0
"ターミナルが開かれていないなら開く"
function! TermOpen()
    if empty(term_list())
        execute "terminal"
    else
        call win_gotoid(win_findbuf(term_list()[0])[0])
    endif
endfunction
"exitterm呼び出し
augroup term-exit
  autocmd!
  autocmd BufEnter * call ExitTerm()
augroup END
"terminalを終了する関数
function! ExitTerm()
    if !empty(term_list())
        let term_tabnr = Bufnr2tabnr(term_list()[0])
        let num_win_in_tabnr = tabpagewinnr(term_tabnr[0], '$')
        if num_win_in_tabnr == 1
            call term_sendkeys(term_list()[0], "exit\<CR>")
        endif
    endif
endfunction
noremap <silent> <space>term :call TermOpen()<CR>
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
" 想定される改行コードの指定する
"set fileformats=unix,dos,mac
set backspace=indent,eol,start
" vimrc に以下のように追記

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save = 1
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" vimprocだけは最初にインストールしてほしい
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


filetype plugin indent on       " restore filetype
set tabstop=2
set shiftwidth=2
set expandtab

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

colorscheme iceberg

" テキスト背景色
au ColorScheme * hi Normal ctermbg=none
" 括弧対応
au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
" スペルチェック
au Colorscheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none

set background=dark

syntax on
"インデントの表示設定
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=white
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=gray
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=248
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=8
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
"ここまでインデントの表示設定

let g:tigris#enabled = 1
let g:tigris#on_the_fly_enabled = 1
let g:tigris#delay = 300

"if dein#tap('unite.vim')
  " unite_setting
  let g:unite_enable_start_insert=1
  " バッファ一覧
  nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
  "ファイル一覧
  " nnoremap <silent> ,uf :<C-n>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> ,uf :<C-u>Unite<Space>file<CR>
  " レジスタ一覧
  nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
  " 最近使用したファイル一覧
  nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
  " 常用セット
  nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
  " 全部乗せ
  nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
  " " ウィンドウを分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  " " ウィンドウを縦に分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  " " ESCキーを2回押すと終了する
  "au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
  "au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
  au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC> :q<CR>
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1

  if has('python3')
    hi CursorLine guifg=#E19972
    " ノーマルモードで起動
    call denite#custom#option('default', {'mode': 'normal'})
    " jjでノーマルモードに
    call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')
    " grep検索
    nnoremap <silent> ,g  :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
    " カーソル位置の単語をgrep検索
    nnoremap <silent> ,cg :<C-u>DeniteCursorWord grep -buffer-name=search-buffer-denite<CR>
    " grep検索結果の再呼出
    nnoremap <silent> ,gg  :<C-u>Denite -resume  -buffer-name=search-buffer-denite<CR>
  else
    " grep検索
    nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    " カーソル位置の単語をgrep検索
    nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
    " grep検索結果の再呼出
    nnoremap <silent> ,gg  :<C-u>UniteResume search-buffer<CR>
  endif
  " ディレクトリを指定してgrep検索
  nnoremap <silent> ,dg  :<C-u>Unite grep -buffer-name=search-buffer<CR>
  " unite grep に ag(The Silver Searcher) を使う
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif
  nnoremap <silent> ,e  :<C-u>Unite file_rec/async:!<CR>

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
"次のウインドウに移動
nnoremap sn <C-w>w
"nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap tt :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', 'build/', '__pycache__/',
      \ 'images/', '*.o', '*.make',
      \ '*.min.*',
      \ 'img/', 'fonts/', 'log/'])
"unite-rails
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
\ 'ignore_pattern', join([
\ '\.git/',
\ 'vendor/bundle',
\ ], '\|'))
noremap ,rc :<C-u>Unite rails/controller<CR>
noremap ,rm :<C-u>Unite rails/model<CR>
noremap ,rv :<C-u>Unite rails/view<CR>
noremap ,rh :<C-u>Unite rails/helper<CR>
noremap ,rs :<C-u>Unite rails/stylesheet<CR>
noremap ,rj :<C-u>Unite rails/javascript<CR>
noremap ,rr :<C-u>Unite rails/route<CR>
noremap ,rg :<C-u>Unite rails/gemfile<CR>
noremap ,rt :<C-u>Unite rails/spec<CR>
nnoremap <silent> ,cell :<C-u>Unite file_rec/async:app/cells/ <CR>
nnoremap <silent> ,ser :<C-u>Unite file_rec/async:app/services/ <CR>
nnoremap <silent> ,rf :<C-u>Unite file_rec/async:app/forms/ <CR>
nnoremap <silent> ,rd :<C-u>Unite file_rec/async:app/decorators <CR>
nnoremap <silent> ,job :<C-u>Unite file_rec/async:app/jobs/ <CR>
"noremap ,re :<C-u>Unite service<CR>

" TAB SETTING
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
      let bufnrs = tabpagebuflist(i)
      let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
      let no = i  " display 0-origin tabpagenr.
      let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
      let title = fnamemodify(bufname(bufnr), ':t')
      let title = '[' . title . ']'
      let s .= '%'.i.'T'
      let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
      let s .= no . ':' . title
      let s .= mod
      let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc 新しいタブを一番右に作る
nnoremap <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
nnoremap <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
nnoremap <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
nnoremap <silent> [Tag]p :tabprevious<CR>
" jjで挿入モードから抜ける設定
inoremap <silent> jj <ESC>


" uniteを利用したyank履歴
let g:unite_source_history_yank_enable =1  "history/yankの有効化
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>

nnoremap <silent><C-e> :NERDTreeToggle<CR>

" 閉じタグ生成
let g:closetag_filenames = '*.html,*.vue'

