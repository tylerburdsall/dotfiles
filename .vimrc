if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug...\n"
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

set modelines=0   " Modelines are a security hazard"
filetype indent plugin on

autocmd BufNewFile,BufRead *.rs set filetype=rust

call plug#begin(expand('~/.vim/plugged'))
" Added plugins
Plug 'tpope/vim-fugitive'
Plug 'frazrepo/vim-rainbow'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'zivyangll/git-blame.vim'
Plug 'ryanoasis/vim-devicons'
" Language-specific plugins

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

" Rust
Plug 'rust-lang/rust.vim'

" Python
Plug 'nvie/vim-flake8'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" vim-airline settings
"
" let buffers be clickable
let g:lightline#bufferline#clickable=1
let g:lightline#bfferline#shorten_path=1
let g:lightline#bufferline#min_buffer_count=1
" colors
let g:airline_powerline_fonts = 1
let g:airline_theme="base16_snazzy"
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" truncate branch names in Airline
let g:airline#extensions#branch#format = 2
let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#tabline#fnamemod = ':t'  " Show just the filename
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" only display file encoding if it is not `utf-8[unix]`
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_base16_improved_contrast = 1 " make inactive statusline stand out a bit more"


" Ale
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc
let g:rustfmt_autosave = 1

let js_fixers = ['prettier', 'eslint']

let g:ale_fixers = {
      \ 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': js_fixers,
      \ 'javascript.jsx': js_fixers,
      \ 'typescript': js_fixers,
      \ 'typescriptreact': js_fixers,
      \ 'css': ['prettier'],
      \ 'json': ['prettier'],
      \ 'python': ['black'],
      \ }

nnoremap K :ALEHover<CR>
nnoremap <silent>gr :ALEFindReferences<CR>
nnoremap <leader>rn :ALERename<CR>
nnoremap <leader>qf :ALECodeAction<CR>
nnoremap <silent>gd :ALEGoToDefinition<CR>
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"



" Formatting
set expandtab       " expand tabs to spaces
set tabstop=2       " tab width
set shiftwidth=2
set softtabstop=2   " simulated tabstop of 4 by using spaces & tabs
set textwidth=80    " where to wrap lines
set fo=crq          " when to wrap lines
set autoindent
" Scroll offset
set scrolloff=10


" Display
set nu              " display line numbers
set nowrap          " don't wrap display

set laststatus=2
set statusline+=%F
set encoding=utf-8

set showmatch       " show matching brackets
set showcmd         " show (partial) comand in status line

set wildmenu
set wildmode=list:longest,full
set ttyfast
set lazyredraw


" Searching
set incsearch       " incremental search
set infercase       " handle case in a smart way in autocomplete
set ignorecase      " ignore case in search
set smartcase       " unless the search string contains upppercase
set hlsearch        " highlighted search

" use fzf in vim
let &rtp = &rtp . "," . trim(system("brew --prefix")) . "/opt/fzf"

" Display whitespace characters nicely when using 'set list'
set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<


syntax enable       " enable syntax highlighting
set mouse=a         " enable use of mouse

" theme settings
set t_Co=256
set background=dark
" You might have to force true color when using regular vim inside tmux as the
" colorscheme can appear to be grayscale with "termguicolors" option enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
colorscheme onedark

"" Git
noremap <Leader>gs :Git status<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gl :Git log<CR

" rainbow brackets settings
let g:rainbow_active = 1

" nerdcommenter settings
let mapleader=","   " set <Leader> to ',' for easier reach
set timeout timeoutlen=1500
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" PYTHON
" conform to PEP08 standards (from https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven )
au BufNewFile,BufRead *.py
 \ set tabstop=4 |
 \ set softtabstop=4 |
 \ set shiftwidth=4 |
 \ set fileformat=unix

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

" GO
" from https://github.com/fatih/vim-go-tutorial
" shortcut for running :GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" shortcut for running :GoBuild
autocmd FileType go nmap <leader>b  <Plug>(go-build)
" Note to self: :GoDef is C-], go back is C-o
" additional highlighting for Go - can cause performance issues
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"


" JSON
let g:vim_json_syntax_conceal = 0 " don't conceal double-quotes
autocmd BufNewFile,BufRead *.json set ft=javascript

" MISC
set scrolloff=5
let loaded_matchparen=1
set hidden
set nobackup
set noswapfile
set pastetoggle=<F2>

" close vim if nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open nerdtree at startup
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif
" Jump to the main window.
autocmd VimEnter * wincmd p


" Map Ctrl+n to show NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Map CtrlP to FZF
nnoremap <C-p> :FZF<CR>

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" ensure we can use mouse to drag windows
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end
