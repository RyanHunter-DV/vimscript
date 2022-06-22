" added for debug mode
set runtimepath+=/home/ryan/prj/GitHub/vimscript

" global variables for uvm files
let g:indentChar = "\t"

"function! ImportPlugin(n)
"	echo printf("source %s",a:n)
"endfunction
"
"
"command! -nargs=1 Import call ImportPlugin('<args>')


command! UVM call uvm#import()

runtime lib/cmds.vim

au BufNewFile,BufRead *sv,*.svh : UVM
