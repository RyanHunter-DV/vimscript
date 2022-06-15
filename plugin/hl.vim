
" added for debug mode
set runtimepath+=/home/ryan/prj/GitHub/vimscript
au! BufNewFile,BufRead *.sv,*.svh : call hl#sv#loadtheme()
au! CursorMoved *.ssv,*.svh : call hl#sv#moveselection()
