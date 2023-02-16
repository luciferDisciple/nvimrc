set nocompatible
set cpoptions+=J " Separate sentences with two spaces
syntax on

" Do not display name of the file at the bottom if only 1 window is open
set laststatus=1

" Display cursor position at the bottom of the window
set ruler

" Display NORMAL commands as they are being typed, at the bottom of the window
set showcmd

" Don't change the shape of the cursor when entering INSERT mode
" :help t_SI
" :help terminal-output-codes (in regular vim)
if has('nvim')
	set guicursor-=i-ci-ve:ver25
endif

" Blink cursor in all modes ('a:')
if has('nvim')
	set guicursor+=a:blinkwait300-blinkon200-blinkoff150
endif

" Show indentation hints, trailing whitespace, and a unicode character
" 'nonbreaking space'
set listchars=tab:\|\ ,trail:·,nbsp:·
set list

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'yegappan/mru'
call plug#end()

" Make Polish diacritics a word-character
if &encoding == "cp1250"
	set iskeyword+=185,230,234,179,241,243,156,159,191,165,198,202,163
	set iskeyword+=209,211,140,143,175
endif


let s:polish_word_char_class = '[_0-9A-Za-zĄąĆćĘęŁłŃńÓóŻżŹź]'
let s:not_polish_word_char_class = '[^_0-9A-Za-zĄąĆćĘęŁłŃńÓóŻżŹź]'

function SwapNextWord()
	let l:save_cursor = getcurpos()
	let l:subst_command  = 's/\(\%#' . s:polish_word_char_class . '\+\)'
	let l:subst_command .= '\(' . s:not_polish_word_char_class . '\+\)'
	let l:subst_command .= '\(' . s:polish_word_char_class . '\+\)'
	let l:subst_command .= '/\3\2\1/'
	call s:MoveToStartCurrentWord()
	execute l:subst_command
	call setpos('.', l:save_cursor)
endfunction

function SwapNextCapitalWord()
	let l:save_cursor = getcurpos()
	call s:MoveToStartCurrentWord()
	s/\(\%#\S\+\)\(\s\+\)\(\S\+\)/\3\2\1/
	call setpos('.', l:save_cursor)
endfunction

function s:MoveToStartCurrentWord()
	normal "_yiw
endfunction

" swap the current word with the next, without changing the cursor position
" https://vim.fandom.com/wiki/Swapping_characters,_words_and_lines
nmap <silent> gw :call SwapNextWord()<CR>
nmap <silent> gW :call SwapNextCapitalWord()<CR>


" :term opens WSL instead of CMD when on MS Windows
" https://vi.stackexchange.com/a/16436
if has("win32")
    set shell=C:\Windows\Sysnative\wsl.exe
    set shellpipe=|
    set shellredir=>
    set shellcmdflag=
endif

function XMLReformatBuffer()
	%!xmllint --format --noent -
	%s/&amp\;/\&/ge
endfunction

" Quit INSERT mode, faster
inoremap jj <Esc>

" Insert current timestamp
nmap <F5> "=strftime("%F")<CR>P
imap <F5> <C-R>=strftime("%F")<CR>
imap <F6> [<C-R>=strftime("%F %H:%M")<CR>]
" Reopen current file, assuming UTF-8 encoding
nmap <F8> :e ++enc=utf8<CR>

" Jump to the next occurance of the '<++>' sequence, remove it, and
" enter INSTERT mode
" 'j' in the mapping stands for 'jump'
inoremap <C-j> <Esc>:call<Space>search('<++>')<CR>"_cf>
nmap <C-j> i<C-j>

" Convert highlighted text to CamelCase
vmap <leader>t :s/\<\(\w\)\(\S*\)/\u\1\L\2/g<CR>

" Insert non-breaking space
inoremap <c-space> <c-k>NS

" Convert characters, added in INSERT mode, to upper case
nmap <leader>u `[v`]<BS>gU

" vimwiki
let wiki = {}
let wiki.name = 'Personal'
let wiki.path = '~/Documents/vimwiki/'
let wiki.list_margin = 0

let g:vimwiki_list = [wiki]

" language messages en_US

" Ignore URL-s while performing spell check
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

" This plugin makes the "%" command jump to matching HTML tags,
" if/else/endif in Vim scripts, etc.
" :help matchit-install
packadd! matchit

" Save and execute currently edited bash script:
autocmd FileType sh nnoremap <buffer> <F10> :up<bar>term bash %<CR>A

autocmd FileType python setlocal expandtab
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType python nnoremap <buffer> <F9> :sp<bar>update<bar>term python3 -m doctest % && echo All tests passed.<CR>A
" Execute script in the current file:
" (https://stackoverflow.com/a/39996978/13168106)
autocmd FileType python nnoremap <buffer> <F10> :update<bar>split<bar>term python3 %<CR>A

autocmd FileType xml nnoremap <buffer> <leader>f :call XMLReformatBuffer()<CR>
let g:xml_syntax_folding=1
autocmd FileType xml setlocal expandtab
autocmd FileType xml setlocal shiftwidth=4
autocmd FileType xml setlocal tabstop=4
autocmd FileType xml setlocal softtabstop=4
autocmd FileType xml setlocal nowrap
autocmd FileType xml setlocal foldmethod=syntax
autocmd FileType xml setlocal noautoindent

autocmd FileType html setlocal shiftwidth=2 tabstop=2

autocmd FileType ruby setlocal expandtab
autocmd FileType ruby setlocal shiftwidth=4
autocmd FileType ruby setlocal softtabstop=4
autocmd FileType ruby setlocal tabstop=4
autocmd FileType ruby nnoremap <buffer> <F10> :update<bar>term ruby %<CR>

autocmd FileType vimwiki setlocal enc=utf8
autocmd FileType vimwiki setlocal nowrap
autocmd FileType vimwiki setlocal tw=79
autocmd FileType vimwiki setlocal expandtab
autocmd FileType vimwiki setlocal shiftwidth=4
autocmd FileType vimwiki setlocal softtabstop=4

autocmd FileType javascript setlocal expandtab
autocmd FileType javascript setlocal shiftwidth=4
autocmd FileType javascript setlocal nowrap
autocmd FileType javascript setlocal tabstop=4
autocmd FileType javascript setlocal softtabstop=4

autocmd FileType json setlocal expandtab
autocmd FileType json setlocal shiftwidth=4
autocmd FileType json setlocal nowrap
autocmd FileType json setlocal tabstop=4
autocmd FileType json setlocal softtabstop=4

autocmd FileType mail setlocal linebreak
autocmd FileType mail setlocal spelllang=pl
autocmd FileType mail setlocal spell
autocmd FileType mail nnoremap j gj
autocmd FileType mail nnoremap k gk
autocmd FileType mail nnoremap $ g$
autocmd FileType mail nnoremap ^ g^
autocmd FileType mail nnoremap 0 g0
