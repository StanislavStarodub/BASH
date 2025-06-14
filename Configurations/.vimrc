" Vim configuration file with categorized settings and version checks

" === General Settings ===
" Disable Vi compatibility mode if enabled (modern Vim default)
if &compatible
    set nocompatible
endif

" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Set file encoding to UTF-8 for this script
scriptencoding utf-8

" Store up to 1000 commands and search history
set history=1000

" === Display Settings ===
" Set color scheme to delek
colorscheme delek

" Enable syntax highlighting
syntax on

" Show absolute and relative line numbers
if has('linebreak')
    set number relativenumber
endif

" Display cursor position (line, column) in the status line
set ruler

" Show partial commands in the status line
set showcmd

" === Text Formatting ===
" Set maximum line width for text wrapping
set textwidth=90

" Set right margin to wrap text 10 characters from edge
set wrapmargin=10

" Break lines at word boundaries, not mid-word
set linebreak

" Wrap searches to the beginning of the file
set wrapscan

" === Indentation Settings ===
" Enable automatic indentation based on previous line
set autoindent

" Set tab width to 4 spaces visually
set tabstop=4

" Use 2 spaces for indentation with >> and <<
set shiftwidth=2

" Simulate 2 spaces when pressing Tab in insert mode
set softtabstop=2

" Replace tabs with spaces
set expandtab

" Insert/delete spaces according to shiftwidth at line start
set smarttab

" === Search Settings ===
" Enable search highlighting, incremental search, and case-insensitive search
" Smartcase ignores case unless pattern contains uppercase
set hlsearch incsearch ignorecase smartcase

" Clear search highlighting with Ctrl-F8
nnoremap <C-F8> :nohlsearch<CR>

" Make * highlight word under cursor without moving to next match
nnoremap * *N

" === Window and Tab Settings ===
" Allow windows to be minimized to zero height
set winminheight=0

" Maximize active window height
set winheight=9999

" Prevent automatic resizing of windows to equal size
set noequalalways

" Open new splits below and to the right of current window
set splitbelow splitright

" Navigate splits with Ctrl-J/K/L/H
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Cycle to next window with Tab
nnoremap <Tab> <C-W>w

" Cycle to previous window with Shift-Tab
nnoremap <S-Tab> <C-W>W

" Switch to next tab with Ctrl-Tab
nnoremap <C-Tab> :tabnext<CR>

" Switch to previous tab with Ctrl-Shift-Tab
nnoremap <C-S-Tab> :tabprevious<CR>

" Move current tab left with Alt-Left
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>

" Move current tab right with Alt-Right
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Close current tab with Ctrl-W t (optional, remove if not needed)
nnoremap <C-W>t :tabclose<CR>

" === Plugin Settings ===
" Load man.vim plugin for viewing man pages
runtime ftplugin/man.vim

" Use :Man as keyword lookup command (e.g., K on a word)
set keywordprg=:Man