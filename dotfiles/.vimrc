" Must set it before referenced since it gets expanded at use
let mapleader = "\<Space>"

"#############"
"## Plugins ##"
"#############"

filetype off
set nocompatible " disables vi compatability mode

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/neocomplete' " allows completion, such as words, methods, functions, etc.
Plugin 'Shougo/neosnippet' " allows snippet completion
Plugin 'Shougo/neosnippet-snippets' " actual snippets
Plugin 'altercation/vim-colors-solarized' " soloraized color scheme
Plugin 'bling/vim-airline' " minimal status line
Plugin 'christoomey/vim-tmux-navigator' " use ctrl-(h/j/k/l) to seamlessly navigate vim splits or tmux panes
Plugin 'davidhalter/jedi-vim' " python highlighting, goto, etc. Need to learn more and better utilize
Plugin 'elzr/vim-json' " adds json specific highlighting (instead of just js)
Plugin 'fatih/vim-go' " damn good go plugin
Plugin 'haya14busa/incsearch.vim' " improved incremental search, highlights all matches
Plugin 'kana/vim-textobj-entire' " used for vim-expand-region config
Plugin 'kana/vim-textobj-indent' " used for vim-expand-region config
Plugin 'kana/vim-textobj-user'   " used for vim-expand-region config
Plugin 'majutsushi/tagbar' " Shows ctags (ex for go-to definition)
Plugin 'myint/syntastic-extras' " extra syntax checking stuff, such as json, yaml
Plugin 'rking/ag.vim' " Uses ag to search files for a string
Plugin 'scrooloose/nerdtree' " file explorer
Plugin 'vim-airline/vim-airline-themes' " Use Solarized Light theme for statusline
Plugin 'scrooloose/syntastic' " syntax checking
Plugin 'terryma/vim-expand-region' " expand visual selection by repeating key hit
Plugin 'tmux-plugins/vim-tmux' " tmux syntax highlighting and a few others
Plugin 'tpope/vim-commentary' " Auto comment line (gcc) or visual block (gc)
Plugin 'tpope/vim-repeat' " allows plugin actions to be repeated as a whole with '.' instad of last native action
Plugin 'tpope/vim-sensible' " some sensible vim defaults, though I think most are overwritten below.

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

"####################"
"## Plugin Options ##"
"####################"

set background=light
colorscheme solarized

" ## syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Uses pylint_django to ignore errors from django's metaprogramming
let g:syntastic_python_pylint_args = "--load-plugins pylint_django --disable=F0401"

let g:syntastic_javascript_checkers = ['json_tool'] " from myint/syntastic-extras
let g:syntastic_yaml_checkers = ['pyyaml'] " from myint/syntastic-extras

" ## vim-json
let g:vim_json_syntax_conceal = 0

" ## Tagbar
nmap <Leader>c :TagbarToggle<CR>

" ## NerdTree
let NERDTreeShowHidden=1

map <C-n> :NERDTreeToggle<CR>
" Close vim if only nerdtree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ## incsearch.vim
" Replaces default searches to basically highlight all matches instead of just first
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ## neocomplete 
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
" " Enable omni completion.
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

" choose highlighted match without inserting newline
inoremap <silent> <CR> <C-r>=<SID>select_without_newline()<CR>
function! s:select_without_newline()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" ## neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ### vim-expand-region ###
" Use 'v' for vim-expand-region
vmap v         <Plug>(expand_region_expand)
vmap <Leader>v <Plug>(expand_region_shrink)
" Add support for more levels. Can't comment inside block, so have to outside
" Support nesting of 'around' brackets
" Support nesting of 'around' parentheses
" Support nesting of 'around' braces
" 'inside indent'. Available through https://github.com/kana/vim-textobj-indent
" 'around indent'. Available through https://github.com/kana/vim-textobj-indent
call expand_region#custom_text_objects({
      \ 'a]' :1, 
      \ 'ab' :1, 
      \ 'aB' :1, 
      \ 'ii' :0, 
      \ 'ai' :0, 
      \ })

" ## vim-go ##
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>s  <Plug>(go-implements)
au FileType go nmap <Leader>i  <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>r  <Plug>(go-run)
au FileType go nmap <Leader>b  <Plug>(go-build)
au FileType go nmap <Leader>t  <Plug>(go-test)
au FileType go nmap <Leader>c  <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e  <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"####################"
"## Custom Options ##"
"####################"

syntax enable 

set clipboard=unnamed " Uses system clipboard
set complete+=kspell " adds spell check hints to keyword completion with C-N/C-P
set cursorline " highlight the line cursor is on
set encoding=utf-8 " Default to utf-8
set expandtab " Tabs->Spaces
set foldmethod=indent " fold on indents
set hlsearch " highlight matches, use noh to clear (set to comma)
set ignorecase " Don't worry about case when searching
set lazyredraw " don't redraw the screen when executing non typed commands (like macros)
set matchtime=3 " Tenths of seconds to showmatch
set modelines=0 " Modelines auto loads vim commands in files. Security vuln and don't need
set mouse=a " Enables mouse in all modes, such as scroll and highlight
set nofoldenable " disable folding by default
set number " Shows line numbers
set relativenumber " as relative +/- to current line. With number, shows current line as absolute, and others as relative
set scrolloff=5 " Minimum number of lines before/after cursor at top/bottom
set shiftwidth=0 " Number of characters to insert with << or >>, with 0 it defaults to tabstop
set showmatch " Jump to the corresponding enclosing char when inserting new ones (ex paren, bracket, etc)
set smartcase " Ignores search case except when you use a caps
set spelllang=en_us " language to use for spell checking
set tabstop=4 " number of spaces a tab counts for
set wildmenu " enable command line  completion

autocmd BufRead,BufNewFile *.md setlocal spell " enable spell checking for md files
autocmd BufRead,BufNewFile *.txt setlocal spell " enable spell checking for txt files

" faster quit
nnoremap <Leader>q :q<CR>
" faster exit
nnoremap <Leader>x :x<CR>
" faster write
nnoremap <Leader>w :w<CR>
" Use comma to clear messages
nnoremap <silent> , :silent noh<Bar>echo<CR>
" unfold all
nnoremap F zr
" Fold all
nnoremap f zm
" center search
nnoremap n nzzzv
" center backwards search
nnoremap N Nzzzv

" move down visual row, not line (\n)
nmap j gj
" move up visual row, not line (\n)
nmap k gk

" Doesn't seem to work
" " vp doesn't replace paste buffer
" function! RestoreRegister()
"   let @" = s:restore_reg
"   return ''
" endfunction
" function! s:Repl()
"   let s:restore_reg = @"
"   return "p@=RestoreRegister()\<cr>"
" endfunction
" " Use 
" vmap <silent> <expr> p <sid>Repl()

" Stolen from http://howivim.com/2016/fatih-arslan/
function! s:tab_complete()
  " is completion menu open? cycle to next item
  if pumvisible()
    return "\<c-n>"
  endif

  " is there a snippet that can be expanded?
  " is there a placholder inside the snippet that can be jumped to?
  " Still need to use enter to select, and then tab to fill out snippet
  if neosnippet#expandable_or_jumpable() 
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " if none of these match just use regular tab
  return "\<tab>"
endfunction
" Use tab_complete to determine what to do with tabs in insert mode
imap <silent><expr><TAB> <SID>tab_complete()
