aug commonAutos
autocmd BufNewFile,BufRead *.sv,*.svh,*.svpp : call common#addSVwordsForMatchit()
aug END
