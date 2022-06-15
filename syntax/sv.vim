"
" define highlight groups
let b:theme = {}
au! BufNewFile,BufRead *.sv,*.svh : hl#sv#loadDefaultTheme()
hi group0 term=bold cterm=bold ctermfg=17 ctermbg=190 gui=bold guifg=#00005f guibg=#dfff00


