""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STARTUP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins ##########################################################################################

call plug#begin(stdpath('data') . '/plugged')
" >>>>>>>>>> Enter plugins below this line >>>>>>>>>>
" Make sure you use single quotes

" General
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'kkoomen/vim-doge'
Plug 'lfv89/vim-interestingwords'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdcommenter'
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'TaDaa/vimade'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'

" Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'arzg/vim-colors-xcode'

" <<<<<<<<<< Enter plugins above this line <<<<<<<<<<
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General ##########################################################################################

" Set mapleader
let mapleader=','

" Enable mouse mode
set mouse+=a

" Show commands as you type
set showcmd

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter,BufWritePre * checktime

" Having longer updatetime (default is 4000 ms = 4s)
" leads to noticeable delays and poor user experience
set updatetime=300

" Fast saving (SHORTCUT)
nmap <leader>w :w!<cr>

" :W sudo saves the file (SHORTCUT)
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Disable shortcut to save and quit accidentally
nnoremap ZZ <nop>
vnoremap ZZ <nop>

" Exit INSERT mode quickly!
imap jj <ESC>
imap qq <C-o>

" Automatically strip trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e


" VIM user interface ###############################################################################

" Set 5 lines to the cursor - when moving vertically using j/k
set so=5

" Turn on the Wild menu for command completion
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler
set cursorline

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results and map key to
" turn off highlighting until next search
set hlsearch
nmap \ :noh<cr>

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Open horizontal splits below current buffer by default
set splitbelow

" Open vertical splits on the right
set splitright

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Don't show vim mode (shown on airline already)
set noshowmode

" Show indicators of space, tab etc.
" set list
" set listchars=space:·,tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪

" Show hard line margin at 120 characters
set colorcolumn=120

" Always show the sign column / gutter
set signcolumn=yes

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Show current line number and relative line numbers (SHORTCUT)
set number
nmap <leader>: :set number!<cr>
nmap <leader>; :set relativenumber!<cr>

" Exit INSERT mode when focus is lost from the buffer
autocmd BufLeave,TabLeave,FocusLost * call feedkeys("\<C-\>\<C-n>")


" Colors and Fonts #################################################################################

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"For Neovim 0.1.3 and 0.1.4
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799
" Based on Vim patch 7.4.1770 (`guicolors` option)
if (has("termguicolors"))
  set termguicolors
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set background=dark
colorscheme xcodedark


" Files, backups and undo ##########################################################################

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb

" Don't store swap files in the same directory
set directory=~/.vim/tmp/swap//
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
endif

" Go to last line of change (helpful to see which line will be undo'd)
nmap U `.

" Autosave on losing focus / leaving the buffer
autocmd BufLeave,TabLeave,FocusLost * silent! update


" Text, tab and indent related #####################################################################

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 120 characters
set lbr
set tw=120

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


" Moving around buffers ############################################################################

" Smart way to move between windows
map <S-j> <C-W>j
map <S-k> <C-W>k
map <S-h> <C-W>h
map <S-l> <C-W>l

map <C-S-l> :bnext<cr>zz
map <C-S-h> :bprevious<cr>zz
nnoremap <C-@> :bnext<cr>zz

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Return to last edit position when opening files (you want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Editing mappings #################################################################################

" Move to beginning/end of line:
nnoremap B ^
vnoremap B ^
xnoremap B ^
nnoremap E $
vnoremap E $
xnoremap E $

" Move a line of text up/down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Use space/enter/backspace/tab as intended
nnoremap <space> i<space><esc><right>
nnoremap <cr> i<cr><esc>
nnoremap <bs> "_X
nnoremap <tab> <S->><S->>
nnoremap <S-tab> <S-<><S-<>
vnoremap <tab> >gv
vnoremap <S-tab> <gv

" Make the d key delete instead of cut
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Use leader+d for cut instead
nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Quick delete words
nnoremap <leader><bs> "_diw
inoremap <leader><bs> <C-o>"_diw

" Replace a word
nnoremap <leader>r viwp

" Copy a word
nnoremap <leader>y yiw


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Black ############################################################################################

" Run Black on save
autocmd BufWritePre *.py execute ':Black'


" deoplete.nvim ####################################################################################

" Use deoplete.
let g:deoplete#enable_at_startup=1


" echodoc.vim ######################################################################################

" Enable echodoc
let g:echodoc#enable_at_startup=1

" Where the documentation is displayed
let g:echodoc#type = 'echo'


" Gundo ############################################################################################

"Display the undo tree with <leader>u.
nnoremap <leader>u :GundoToggle<CR>

"Add this line if you are using Python 3.
let g:gundo_prefer_python3=1

" Show Gundo window on the right
let g:gundo_right=1
let g:gundo_width=60


" jedi-vim #########################################################################################

" Don't use autocompletion (use deoplete-jedi instead)
let g:jedi#completions_enabled = 0

" Don't show preview window
autocmd FileType python setlocal completeopt-=preview

" Don't show function call signatures
let g:jedi#show_call_signatures=0

" Use with SuperTab
let g:SuperTabDefaultCompletionType='<c-x><c-o>'

" Custom mappings
let g:jedi#goto_command = "<leader><leader>g"
let g:jedi#goto_assignments_command = "<leader>g"


" NERD Commenter ###################################################################################

" Map comment toggle
nnoremap <leader>cc :call NERDComment(0, "toggle")<cr>

" Only use the above mapping for toggling comments
let g:NERDCreateDefaultMappings=0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs=1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines=1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace=1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines=1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


" NERDTree #########################################################################################

" Start Startify and NERDTree by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | wincmd w | endif

" Toggle NERDTree
nnoremap <C-b> :NERDTreeToggle<cr>

" Set the browser width
let g:NERDTreeWinSize=40

" Show hidden files (starting with period)
let NERDTreeShowHidden=1

" Mirror the open directories across tabs
autocmd BufWinEnter * NERDTreeMirror

" Automatically quit vim if NERDTree is last and only buffer
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add mapping for closing buffers opened by NERDTree the right way
nnoremap <leader>q :bp<cr>:bd #<cr>


" Startify #########################################################################################

let g:startify_session_autoload=1
let g:startify_change_to_vcs_root=1
let g:startify_session_persistence=1

" Add init.vim as bookmark
let g:startify_bookmarks = [{'c': '~/.config/nvim/init.vim'}]

" Move current directory MRU up
let g:startify_lists = [
      \ { 'header': ['   Recent in '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Recent (all)'],         'type': 'files' },
      \ { 'header': ['   Bookmarks'],            'type': 'bookmarks' },
      \ { 'header': ['   Sessions'],             'type': 'sessions' },
      \ ]

" Add shortcut to Startify
nnoremap <leader>ss :Startify<cr>


" UltiSnips ########################################################################################

" Trigger configuration
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window
let g:UltiSnipsEditSplit="vertical"


" vim-airline ######################################################################################

" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled=1
let g:airline_theme="papercolor"


" vim-doge #########################################################################################

" The mapping to trigger DoGe
let g:doge_mapping='<leader><leader><tab>'

" Set python documentation to google style
let g:doge_doc_standard_python = 'google'


" vim-gitgutter ####################################################################################

let g:gitgutter_map_keys=0


" vim-interestingwords #############################################################################

" Unset default mapping and set new mapping
nnoremap <Plug> <Plug>InterestingWords
nnoremap <silent> <leader>c :call InterestingWords('n')<cr>
vnoremap <silent> <leader>c :call InterestingWords('v')<cr>
nnoremap <silent> <leader>C :call UncolorAllWords()<cr>
nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGE SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python ###########################################################################################

" Show margin at 80 characters
au! BufNewFile,BufRead *.py set colorcolumn=80


" Svelte ###########################################################################################

" Set the filetype as HTML
au! BufNewFile,BufRead *.svelte set ft=html

" Set up ALE linters
let g:ale_linter_aliases = {'svelte': ['css', 'javascript', 'html']}
