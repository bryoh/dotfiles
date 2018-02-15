execute pathogen#infect()
syntax on
filetype plugin indent on
set number

" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()
"Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Code folding with simply fold
set nofoldenable "disable automatic folding
nnoremap <space> zc
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let b:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0
let b:SimpylFold_fold_import=0

"Solarized colours
syntax enable
set background=dark
colorscheme solarized

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=0
"let g:ycm_goto_buffer_command = 'new-or-existing-tab'
set completeopt+=preview
" map <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
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

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent | 
    \ set fileformat=unix

"Get NERDTree 
autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p " Do not focus cursor on NERDTree 
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"Syntastic
let python_highlight_all=1
syntax on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"bootstrap snippets
let g:snipMate = {}
" let g:snips_trigger_key = '<tab>'


"Powerline-plugin
"python from powerline.vim import setup as powerline_setup
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"python powerline_setup()
"python del powerline_setup
set laststatus=2
set t_Co=256

"vim notes
:let g:notes_directories = ['~/Documents/Notes']
