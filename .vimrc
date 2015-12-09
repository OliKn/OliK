" vim: set ft=vim fdm=marker:  // 
" {{{ Vundle filetype off / on
filetype off                   " required for Vundle
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My Bundles here:
" Plugin 'kshenoy/vim-signature'

" Plugin 'formatvim'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'scrooloose/nerdtree'
" vimproc is needed for eg. unite, vimShell, but
" the is a package in AUR: vim-vimproc
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'shougo/vimshell'
" Alternativen zu ctrlp:
" unite: https://github.com/Shougo/unite.vim
Plugin 'Shougo/unite.vim'
Plugin 'godlygeek/tabular'

" Colorthemes
" -----------
" jellybeans: dark colorcheme
Plugin 'nanotech/jellybeans.vim'
Plugin 'github-theme'
Plugin 'Solarized'
Plugin 'pyte'

Plugin 'LanguageTool'
" NrrwRgn: open region in a new window, protects the rest
Plugin 'NrrwRgn'


Plugin 'sjl/gundo.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
 
" Plugin 'chrisbra/unicode.vim'

" Plugin 'dhruvasagar/vim-table-mode'

filetype plugin indent on
" }}}
runtime ftplugin/man.vim
" set t_Co=256        " terminal support 256 Colors

let mapleader = ","
let maplocalleader = ","
" {{{ augroup ok_autocommands
" if !exists("autocommands_loaded")
"    let autocommands_loaded = 1
" endif
augroup ok_autocommands
    au!
    " Set no cursorline in insert mode
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline

    au BufNewFile,BufRead ~/Notebooks/* set ft=alldown 
    au BufRead,BufNewFile *.md set ft=markdown
    au BufRead,BufNewFile *.tmp set ft=markdown tw=78 spell
    " Use :help instead of Shell man with K
    " au BufRead,BufNewFile .vimrc set keywordprg=
    au BufRead,BufNewFile datSaf.txt setlocal nospell

    au FileType xhtml setlocal shiftwidth=2 iskeyword+=-
    au FileType html setlocal shiftwidth=2 iskeyword+=-
"     au FileType xhtml iabbrev </ </<C-X><C-O> 
"     au FileType html iabbrev </ </<C-X><C-O> 
    au FileType text setlocal spell tw=78
    au FileType css nnoremap <buffer> <localleader>cv '<O/*<esc>'>o*/<esc>
    au FileType css nnoremap <buffer> <localleader>cc I/*<esc>A */<esc>
    au FileType css vnoremap <buffer> <localleader>cv <esc>'<O/*<esc>'>o*/<esc>
augroup END

" augroup trailing
"     au!
"     au InsertEnter * :set listchars-=trail:⌴
"     au InsertLeave * :set listchars+=trail:⌴
" augroup END

" }}}
" {{{ Statusline
" ToDo:
" Setting colors for the statusline: %1…9*
" eg:
" :hi User1 guibg=#00ff00 guifg=yellow
" help: | *hl-User1* | | *:highlight* |
set statusline=                        " Defines the content of the statusline
set stl+=ｂ\ %n\ ⁝                     " Buffer number
set stl+=%3*\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}/ " working directory
set stl+=⁝%4*%f\                        " Filename
set stl+=%(%1*%m%r%w\ %)
"              | | |
"              | | +-- Preview window
"              | +---- Read-only
"              +------ Modified
set stl+=%*[%{&ff}]\                   " File format
set stl+=%(%y\ %)%*                    " File type
set stl+=%(%{&paste?'[paste]':''}\ %)  " Paste mode
set stl+=%<                            " Break here if line is too long
set stl+=%=                            " Left/right separator
set stl+=%2*
set stl+=»+%{indent('.')/&sw}\         " Indent level
set stl+=%2*0x%-8B                     " current char
set stl+=↳%-14.(%l_%L,%c%V%)              " offset
" }}}
" {{{ set Options
" set bs=2                " Allow backspacing over everything in insert mode
set backspace=indent,eol,start  " Same as bs=2
set nohlsearch
set lcs=tab:»·,trail:·,extends:→,precedes:←,nbsp:‗
set modeline
set rnu                                         " relative line numbers
set nu                                          " show lineno for active line
set clipboard+=unnamed
set directory=~/.vim/tmpdir/swap,.,/tmp
set backupdir=~/.vim/tmpdir/backup,.,/tmp 
set history=1000 
set undofile                                    " Keep undo history
set undodir=~/.vim/tmpdir/undo,.,/tmp
" set spellfile=~/.vim/spell/myspell_de.utf-8.add
set aw                          " set autowrite
set showbreak=⤥\ 
set colorcolumn=+1              " show column textwidth+1
" formatoptions (:h fo-table) jcroql
set formatoptions-=r            " Do not add comment after hitting Return
set formatoptions-=o            " Do not add comment after hitting 'o'
set formatoptions+=j            " remove comment lead when joining lines
set noswapfile
set foldcolumn=3

set cpoptions+=n                " use numberbar for wrapped text
" set cpoptions+=$              " when making a change dont delete, show a $
set notildeop                   " switch case under Cursor, without motion
set virtualedit+=block
set virtualedit+=insert	

colo okdark
" table mode settings
let g:table_mode_corner_corner='+'

" }}}

" {{{ NERDTree
let NERDTreeChDirMode=2     " Change CWD to NTree-Root
let NERDTreeHijackNetrw=0   " Do not use NTree for netrw
let NERDTreeShowBookmarks=1 " Show Bookmarks on startup
" }}}
" " {{{ ctrlp
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" " 1 search by filename
" " 0 by full path
" let g:ctrlp_by_filename = 1
" let g:ctrlp_working_path_mode = 'wr'
" let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" " }}}

" {{{ unite:

let g:unite_enable_start_insert = 1
" let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
" let g:unite_winheight = 10

" call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
"       \ 'ignore_pattern', join([
"       \ '\.git/',
"       \ ], '\|'))
call unite#custom_source('file_rec,file_rec/async', 'ignore_pattern', '\(\.html$\|\.git/\)')

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" nnoremap <C-P> :<C-u>Unite -no-split -buffer-name=files -start-insert buffer file_rec/async:!<cr>
nnoremap <C-P> :<C-u>Unite -no-split -buffer-name=files -start-insert<cr>
nnoremap <leader>a :set nopaste<cr>:<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" }}}

" {{{ neocomplete

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php =
"\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.c =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.cpp =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For smart TAB completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}
" }}}

" {{{ ToggleNumber(), show linenumber, relative linenumbers
" Toggle show linenumber, relative linenumbers
function! ToggleNumber()
    if (&relativenumber) 
        echom "RelNumber On"
        set norelativenumber 
    else
        if (&number)
            echom "Number On"
            set nonumber
        else
            set number
            set relativenumber
        endif
    endif
endfunction
nnoremap <leader>r :call ToggleNumber()<CR>

"}}}
"{{{ Toggle Vexplore with Ctrl-E
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
" map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
"}}}

" Use Help for vertical help
command! -nargs=* -complete=help Help vertical belowright help <args>

" {{{ BlinkLine(); map n and N
function! BlinkLine (blinktime)
    exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction

" nnoremap <silent> n n:call BlinkLine(0.3)<cr>
" nnoremap <silent> N N:call BlinkLine(0.3)<cr>
"}}}
" {{{ Mappings
" learnvimscript the hard way:
" nnoremap <leader>ev :tab drop $MYVIMRC<cr>

" noremap! <S-Insert> <C-R>+
" nnoremap <S-Insert> "+gP
" snoremap <S-Insert> <Esc>gvc<C-R>+
" xnoremap <S-Insert> c<C-R>+<Esc>


vnoremap Y y`>
nnoremap yy ^y$
nnoremap <leader>v `[v`]
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>ed :tabe ~/.vim<cr>
nnoremap <leader>ea :tabe ~/.config/awesome/rc.lua<cr>
nnoremap <leader>ep :edit ~/.privat/datSaf.txt<cr>
nnoremap <leader>et :edit <cfile>:s?html$?txt?<cr>
nnoremap <leader>sv :source %<cr>
nnoremap <leader>ss :w<cr>:source %<cr>:echo "written and sourced"<cr>
nnoremap <leader>r :set spell!<cr>:set spell?<cr>
nnoremap <leader>ma :w<cr>:! asciidoc --theme=compact %<cr><cr>
nnoremap <leader>id "=strftime("%Y-%m-%d %A")<CR>p
inoremap °° __<C-R>=strftime("%Y-%m-%d %A")<CR>__
nnoremap <leader>it "=strftime("%H:%M")<CR>p
inoremap ™™ _<C-R>=strftime("%H:%M")<CR>_
nnoremap <leader>iu YpVr=

"nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F4> :NERDTreeToggle
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>cb I__<esc>A__<esc>
nnoremap <leader>ci I_<esc>A_<esc>
nnoremap <leader>f :!dolphin "<cfile>" &<CR><CR>
nnoremap <leader>o :!xdg-open "<cfile>" &<CR>
" nnoremap <leader>w p
nnoremap <leader>w :call PrevOrLastWindow()<cr>
nnoremap <leader>nc :NeoCompleteToggle<cr>

function! PrevOrLastWindow()
    let lastwin = winnr('#')
    if lastwin > 0 && lastwin != winnr()
        execute "wincmd p"
        echo "Previous Window"
    else
        execute "wincmd w"
        echo "Next Window"
    endif
endfunction

nnoremap <leader>W =
nnoremap <leader>q :wq<CR>
nnoremap q; q:
" nnoremap <C-Q> :qa!<CR> " done in gvim.rc
nnoremap <leader>h :set hlsearch!<CR>:set hlsearch?<CR>
nnoremap <Space> 
nnoremap <BS> 
" noremap <silent> <c-l> :nohl<cr><c-l>

nnoremap : ;
vnoremap : ;

" Use sane regexes.
" nnoremap / /\v
" vnoremap / /\v

nnoremap <leader>> :tabnext<CR>
nnoremap <leader>< :tabprevious<CR>

" Keep search matches in the middle of the window.
" nnoremap n nzz
" nnoremap N Nzz

" It's 2013.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" dj should delete two lines
nnoremap dj @='2dd'<CR>

nnoremap <leader><Space> za

inoremap jj <Esc>
inoremap uu ü
inoremap UU Ü
inoremap aa ä
inoremap AA Ä
inoremap oee ö
inoremap Oee Ö
" inoremap oo ö
" inoremap OO Ö

" Use spelling in insert mode
inoremap <c-s> <c-x><c-s>

" }}}
" {{{ Scratch
" scratch:
"================================================

" inoremap <CR> <C-]><C-G>u<CR>


"  For example, the following will map <Tab> to either actually insert a <Tab> if
"  the current line is currently only whitespace, or start/continue a CTRL-N
"  completion operation: >
"
"	function! CleverTab()
"	   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"	      return "\<Tab>"
"	   else
"	      return "\<C-N>"
"	   endif
"	endfunction
"	inoremap <Tab> <C-R>=CleverTab()<CR>
" 
" highlight ColorColumn ctermbg=magenta
" set colorcolumn=81
" 
" call matchadd('ColorColumn', '\%81v', 100) " s. :h /\%v

" vim: set fdm=marker:

" set wildmenu              " better auto complete
" set wildmode=longest,list " bash-like auto complete
" set gdefault              " default s//g (global)
" Toggle text wrapping
" nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>


" 
" function! NumberToggle()
"     if(&relativenumber == 1)
"         set number
"     else
"         set relativenumber
"     endif
" endfunction
"
" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
" nmap <silent> ,qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Make shift-insert work like in Xterm
" map <S-Insert> <MiddleMouse>
" map! <S-Insert> <MiddleMouse>
" 
" function! MoveOrOpenSplit() " {{{
" let curNr = winnr()
" wincmd w
" if winnr() == curNr
"     exe 'vsplit'
"     wincmd w
" endif
" endfunction " }}}
"}}}
