if exists("g:loaded_hello_world")
    finish
endif
let g:loaded_hello_world = 1

function! HelloWorld()
    echo "Hello, Vim world!"
endfunction

function! DisplayVimVersion()
    echo "Vim version: " . v:version
endfunction

function! DisplayCurrentTime()
    echo "Current time: " . strftime("%Y-%m-%d %H:%M:%S")
endfunction

command! HelloWorld call HelloWorld()
command! VimVersion call DisplayVimVersion()
command! CurrentTime call DisplayCurrentTime()

" Optional: Create mappings to quickly show the Vim version and current time
nnoremap <Leader>svh :HelloWorld<CR>
nnoremap <Leader>svv :VimVersion<CR>
nnoremap <Leader>svt :CurrentTime<CR>
