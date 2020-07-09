set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'w0rp/ale'
Plugin 'vim-syntastic/syntastic'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
"Plugin 'SirVer/ultisnips'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-heroku'
Plugin 'tpope/vim-dadbod'
Plugin 'gregsexton/gitv'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/gv.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-airline/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'vimlab/split-term.vim'
Plugin 'janko-m/vim-test'
Plugin 'alfredodeza/pytest.vim'
Plugin 'altercation/solarized'
Plugin 'dylanaraps/wal.vim'
Plugin 'yggdroot/indentline'
Plugin 'ciaranm/inkpot'
Plugin 'changyuheng/color-scheme-holokai-for-vim'
Plugin 'ambv/black'
Plugin 'baskerville/bubblegum'
Plugin 'reedes/vim-thematic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'blindFS/vim-taskwarrior'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'vimwiki/vimwiki'
Plugin 'mattn/calendar-vim'
Plugin 'kien/ctrlp.vim'
"search and replace multiple files 
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim' 
Plugin 'Lokaltog/vim-powerline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'plytophogy/vim-virtualenv'
Plugin 'marijnh/tern_for_vim'
"Plugin 'skanehira/docker.vim'
Plugin 'mzlogin/vim-markdown-toc'
"You need to have nodejs and yarn
Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

"To install from command line: vim +PluginInstall +qall
call vundle#end()            " required
filetype plugin indent on    " required

set nu "set number 
set rnu "I like relative line numbers now"
set ruler 
set wildmenu 

" Copy with leader key * from/to vim + from/to system
noremap <Leader>y *+y 
noremap <Leader>p *+p
noremap <Leader>Y "+y
noremap <Leader>P "+p

"Split behavior 
"set splitbelow
"set splitright

"Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set foldmethod
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
set syntax=javaScript

"Code folding with simply fold
set nofoldenable "disable automatic folding
"nnoremap <space> zc
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let b:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0
let b:SimpylFold_fold_import=0

"Solarized colours
syntax enable
set background=dark
let g:solarized_termcolors=256

let g:solarized_termtrans = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'


colorscheme wal
" ---------------------------------- "
"  Python Stuff 
" ---------------------------------- "
map <F8> o__import__('ipdb').set_trace() <CR>
"
" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=0
"let g:ycm_goto_buffer_command = 'split'
set completeopt+=preview
map <F4> :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <F3> :vsplit \| YcmCompleter GoToDefinitionElseDeclaration<CR>
map <F2> :split \| YcmCompleter GoToDefinitionElseDeclaration<CR>
"  Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming
"  language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
"
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"

"to prevent clash with youcompleteme, change snippet trigger
"imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger

" ---------------------------------------------- "
" Configure  Syntax hightlighting, look and feel
" ---------------------------------------------- "
"tab to 4 spaces rules 
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent | 
    \ set fileformat=unix

"Black settings
autocmd BufWritePre *.py execute ':Black'
"let g:black_virtualenv='/.virtualenvs/pit3'
let g:loaded_python3_provider=0
let g:black_linelength=180
let g:black_skip_string_normalization=1

"Test mappings
nmap <silent> t<C-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<C-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g

"pytest mapping 
nmap <silent><Leader>f <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>

"Syntastic
let python_highlight_all=1
syntax on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:ale_fix_on_save = 1


"bootstrap snippets
let g:snipMate = {}
" let g:snips_trigger_key = '<tab>'

" ---------------------------------------------- "
" Configure File browsing 
" ---------------------------------------------- "
"Get NERDTree 
"Open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR> 
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p " Do not focus cursor on NERDTree 
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['^node_modules$[[dir]]', '\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" Git stuff 
let g:gitgutter_max_signs = 500  " default value for detecting changes 

"Powerline-plugin
"python from powerline.vim import setup as powerline_setup
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"python powerline_setup()
"python del powerline_setup
set laststatus=2

" Taskwarrior
let g:task_rc_override = 'rc.defaultheight=0'
let g:task_rc_override = 'rc.defaultwidth=0'
au BufNewFile,BufRead Jenkinsfile setf groovy

" vimwiki 
"
let wiki_1 = {}
let wiki_1.path = '~/friendly-barnacle/vimwiki/'
let wiki_1.path_html = '~/friendly-barnacle/vimwiki_html/'

"let wiki_2 = {}
"let wiki_2.path = '~/friendly-barnacle/vimwiki/'
"let wiki_2.path_html = '~/friendly-barnacle/vimwiki_html/'

let g:vimwiki_list = [wiki_1,] " wiki_2]
"let g:vimwiki_list = [{'path':'~/friendly-barnacle/vimwiki/', 'path_html':'~/friendly-barnacle/vimwiki_html/'}]
