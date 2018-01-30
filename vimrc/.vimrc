call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'reewr/vim-monokai-phoenix'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'
Plug 'nvie/vim-flake8'
Plug 'lepture/vim-velocity'
Plug 'vim-syntastic/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'mxw/vim-jsx'
" Plug 'Quramy/vim-js-pretty-template'
" Plug 'gcmt/taboo.vim'
" Plug 'xolox/vim-misc'
Plug 'Yggdroot/indentLine'
Plug 'tmux-plugins/tmux-yank'
Plug 'scrooloose/nerdtree'
call plug#end()
filetype on                 " required
filetype plugin indent on    " required
syntax on
"Indentation lines on
let g:indentLine_char = '┆'
"set shiftround "always multiple of shiftwidth
"set smarttab "more intelligent handling
"set smartindent "if no ident file
"set foldmethod=indent foldlevel=99 "python-compatible folding
set number "line numbers
set relativenumber "relative numbers too
set clipboard=unnamedplus  " use the clipboards of vim and win
" set paste               " Paste from a windows or from vim
set hlsearch
set incsearch
set ignorecase
set smartcase
set background=dark
" tmp file handling
set nobackup
set nowritebackup
set noswapfile
set laststatus=2
set diffopt+=vertical
set backspace=indent,eol,start

" indent shortcut
vnoremap < <gv
vnoremap > >gv
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:javascript_plugin_jsdoc = 1
" let g:syntastic_mode_map = { 'mode': 'active',
"                            \ 'active_filetypes': ['python', 'javascript'],
"                            \ 'passive_filetypes': [] }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript', 'jsx'],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Tab width
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 expandtab sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd BufRead,BufNewFile *.jsx setlocal ts=2 sw=2 sts=2 expandtab
"autocmd Filetype *.jsx setlocal ts=2 sw=2 expandtab
autocmd Filetype velocity setlocal ts=2 sw=2 expandtab sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab sts=2 sw=2
autocmd BufRead,BufNewFile *.css setlocal ts=2 sw=2 sts=2 expandtab

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" Enable neocomplete
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

"set run commands per filetype
autocmd Filetype python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" set flake settings
" autocmd BufWritePost *.py call Flake8()
autocmd BufWritePost *.py call flake8()

" set indentation lines
let g:indent_guides_start_level = 1

" NERDtree settings
map <C-n> :NERDTreeToggle<CR>

" Syntastic local linter support

let g:syntastic_javascript_checkers = []

function CheckJavaScriptLinter(filepath, linter)
	if exists('b:syntastic_checkers')
		return
	endif
	if filereadable(a:filepath)
		let b:syntastic_checkers = [a:linter]
		let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
	endif
endfunction

function SetupJavaScriptLinter()
	let l:current_folder = expand('%:p:h')
	let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', l:current_folder), ':h')
	let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
	call CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
	call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
endfunction

autocmd FileType javascript call SetupJavaScriptLinter()
vnoremap <leader>p "_dP
au BufNewFile,BufRead *.vm set ft=velocity
