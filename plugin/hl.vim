
" added for debug mode
set runtimepath+=/home/ryan/prj/GitHub/vimscript
au! BufNewFile,BufRead *.sv,*.svh : call hl#sv#loadtheme()
au! CursorMoved *.sv,*.svh : call hl#sv#moveselection()
