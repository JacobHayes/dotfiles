" Must set it before referenced since it gets expanded at use
let mapleader = "\<Space>"

" fish isn't posix compliant
if &shell =~# 'fish$'
  set shell=sh
endif

"#############"
"## Plugins ##"
"#############"

" Automatically install vim-plug and all plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl --create-dirs -fLo ~/.local/share/nvim/site/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " This seems to error with deoplete not installed or something
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'bling/vim-bufferline' " Show the buffers (and number) in status bar
" Plug 'chrisbra/Recover.vim' " allow diff from existing .swp files - doesn't work well with nvim
" Plug 'easymotion/vim-easymotion' " Need to learn more, but it's like vimium's link following
Plug '/usr/local/opt/fzf' " Use the brew installed fzf
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets' " actual snippets
Plug 'Shougo/neosnippet.vim' " allows snippet completion
Plug 'altercation/vim-colors-solarized' " soloraized color scheme
Plug 'bfredl/nvim-miniyank' " Fix block paste in neovim when clipboard=unnamed
Plug 'bling/vim-airline' " minimal status line
Plug 'chr4/nginx.vim' " Nginx conf file syntax highlighting
Plug 'chrisbra/csv.vim' " Fancy CSV viewing
Plug 'christoomey/vim-tmux-navigator' " use ctrl-(h/j/k/l) to seamlessly navigate vim splits or tmux panes
Plug 'dag/vim-fish' " Add fish syntax support
Plug 'davidhalter/jedi-vim' " python highlighting, goto, etc. Using zchee/deoplete-jedi for completion though
Plug 'dense-analysis/ale' " async linting, etc
Plug 'elzr/vim-json' " adds json specific highlighting (instead of just js)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " lots of go helpers
Plug 'kana/vim-textobj-entire' " used for vim-expand-region config
Plug 'kana/vim-textobj-indent' " used for vim-expand-region config
Plug 'kana/vim-textobj-user'   " used for vim-expand-region config
Plug 'majutsushi/tagbar' " Shows ctags (ex for go-to definition)
Plug 'mbbill/undotree' " friendly view for change history
Plug 'mgedmin/coverage-highlight.vim' " Use :HighlightCoverage to show code coverage in file
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace
Plug 'scrooloose/nerdtree' " file explorer
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'terryma/vim-expand-region' " expand visual selection by repeating key hit
Plug 'terryma/vim-multiple-cursors' " Sublime Text style multi-edit
Plug 'tmux-plugins/vim-tmux' " tmux syntax highlighting and a few others
Plug 'tpope/vim-commentary' " Auto comment line (gcc) or visual block (gc)
Plug 'tpope/vim-repeat' " allows plugin actions to be repeated as a whole with '.' instad of last native action
Plug 'tpope/vim-sensible' " some sensible vim defaults, though I think most are overwritten below.
Plug 'tpope/vim-sleuth' " Auto detect space/indent
Plug 'tpope/vim-surround' "Surround text v(highlight)S<character>
Plug 'vim-airline/vim-airline-themes' " Use Solarized Light theme for statusline
Plug 'zchee/deoplete-go', { 'do': 'make' } " async go completion
Plug 'zchee/deoplete-jedi' " async python completion

call plug#end()

" Source plugin config files
for f in split(glob('~/.config/nvim/plugins/*.vim'), '\n')
    exe 'source' f
endfor

"####################"
"## Custom Options ##"
"####################"

if has("mac")
  highlight Normal ctermbg=NONE
  function! SetBackground()
    if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
      set background=dark
    else
      set background=light
    endif
  endfunction

  call SetBackground()
else
  set background=dark
endif


" Use brew python since linters and neovim are installed
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python'

set clipboard=unnamed " Uses system clipboard
set cursorline " highlight the line cursor is on
set expandtab " use spaces
set foldmethod=indent " fold on indents
set ignorecase " Don't worry about case when searching
set lazyredraw " don't redraw the screen when executing non typed commands (like macros)
set matchtime=3 " Tenths of seconds to showmatch
set modelines=0 " Modelines auto loads vim commands in files. Security vuln and don't need
set mouse=a " Enables mouse in all modes, such as scroll and highlight
set nofoldenable " disable folding by default when a fold type is specified
set nojoinspaces " Don't use double spaces when joining lines ending with periods
set number " Shows line numbers
set relativenumber " show numbers as relative to current line.
set scrolloff=5 " Minimum number of lines before/after cursor at top/bottom
set shiftwidth=0 " Number of characters to insert with << or >>, with 0 it defaults to tabstop
set showmatch " Jump to the corresponding enclosing char when inserting new ones (ex paren, bracket, etc)
set smartcase " Ignores search case except when you use a caps
set spell spelllang=en_us " enable spell checking w/ US English
set tabstop=4 " Number of characters/spaces a tab appears as
set textwidth=120 " Start new lines at 120 characters automatically or re-wrap to 120 with gq
set undofile " Store change history between file sessions
set visualbell " don't beep, ex when hitting escape in command mode

autocmd bufreadpre *.md setlocal conceallevel=0 " Don't hide syntax symbols like _

if empty($PY_TEXTWIDTH)
  autocmd bufreadpre *.py setlocal textwidth=88
else
  autocmd bufreadpre *.py let &l:textwidth=str2nr($PY_TEXTWIDTH)
endif

" H/L for faster ^/$
noremap H <home>
vnoremap H <home>
noremap L <end>
vnoremap L <end>
" faster quit, write, and exit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
" Use comma to clear messages
nnoremap <silent> , :silent noh<Bar>echo<CR>
" position search results in center of the page
nnoremap n nzzzv
nnoremap N Nzzzv
" move up/down within wrapped lines (can use arrow keys for \n nav)
nmap j gj
nmap k gk
" Shortcut for :s///g
nmap S :%s//g<LEFT><LEFT>
xmap S :s//g<LEFT><LEFT>
" Shortcut for :s/<last match>//g
nmap <expr> M ':%s/' . @/ . '//g<LEFT><LEFT>'
xmap <expr> M ':s/' . @/ . '//g<LEFT><LEFT>'

" choose the highlighted match without inserting newline - not required for an auto-selected match
function! s:select_without_newline()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <silent> <CR> <C-r>=<SID>select_without_newline()<CR>

" handle tabs in insert mode specially if a completion menu or snippet is open
function! s:tab_complete()
  if pumvisible()
    " a completion menu open is open - cycle to the next item
    return "\<c-n>"
  elseif neosnippet#expandable_or_jumpable()
    " Either a snippet can be expanded or a placeholder can be jumped to
    " Still need to use enter to select, and then tab to fill out snippet
    return "\<Plug>(neosnippet_expand_or_jump)"
  else
    return "\<tab>"
  endif
endfunction
imap <silent><expr><TAB> <SID>tab_complete()
