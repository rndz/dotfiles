set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
" Apperance
Plugin 'altercation/vim-colors-solarized'
"Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'

" Navigation
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'

" Editing
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

Plugin 'vim-scripts/taglist.vim'
Plugin 'fatih/vim-go'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set hlsearch

se wildignore+=*.o,*/.git/*,*/.hg/*,*/.svn/*,*/*cache,*/logs,*/tmp,*.swp,*.jpg,*.png,*.xpm,*.gif,*.ico,*/vendor,web/css,web/js,web/bundles,*/target/*
se wildignore+=*/tags,*/vendor.tags,*.phar,*/node_modules
se clipboard=unnamed

se background=dark

se t_Co=256
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_termtrans=1

try
	colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
endtry


set hidden
set foldmethod=syntax
autocmd Syntax go normal zR

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsSnippetDirectories = ["ultisnip"]

set backspace=2
set number

nmap <leader>2 :setlocal tabstop=2<cr>:setlocal shiftwidth=2<cr>:setlocal softtabstop=2<cr>
nmap <leader>4 :setlocal tabstop=4<cr>:setlocal shiftwidth=4<cr>:setlocal softtabstop=4<cr>
nmap <leader>8 :setlocal tabstop=8<cr>:setlocal shiftwidth=8<cr>:setlocal softtabstop=8<cr>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·    " Highlight trailing spaces and tabs

" create a new file, suggest current directory of the file edited
nmap <leader>c :e <c-r>=expand('%:h')<cr>/

" CtrlP
nmap <C-p> :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlP<cr>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(vendor|assets|web)$',
  \ }
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
        nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
                    \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunc

" ACK, used for silver search aka ag
let g:ackprg = 'ag --nogroup --nocolor --column'
nmap <leader>a :Ack

se colorcolumn=80
set dir=~/.vim_tmp/
set backupdir=~/.vim_tmp/
set undodir=~/.vim_tmp/

function! <SID>StripTrailingWhitespaces()
    " Preparation save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

if has('autocmd')
    augroup Cursor
        autocmd!
        au FocusLost silent! :wa
        " Highlight cursor line
        au insertEnter * se cursorline
        au insertLeave * se nocursorline
        highlight cursorline term=underline cterm=underline ctermbg=0 guibg=#000000

        " Restore cursor position
        au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm$"|endif|endif
    augroup END

    "augroup FileTypes
        "autocmd!
        "au FileType helpfile setlocal nonumber
        "au BufRead,BufNewFile * if index(['go'], &ft) < 0 | setlocal list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·
    "augroup END

    augroup Commands
        autocmd!
        " strip trailing space on write
        au BufWrite * :call <SID>StripTrailingWhitespaces()
    augroup END

endif

map <leader>rr :source ~/.vimrc<CR>

let g:go_fmt_command = "goimports"
"let g:go_list_type = "quickfix"

let g:UltiSnipsExpandTrigger="<F1>"

inoremap {<CR> {<CR>}<Esc>O

"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'go']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

let g:syntastic_go_checkers = ["gofmt"]

nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufWritePost *.go :GoBuild
endif
