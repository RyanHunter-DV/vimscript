function! common#addSVwordsForMatchit()
    let b:match_words='\<begin\>:\<end\>,'
    let b:match_words.='\<class\>:\<endclass\>,'
    let b:match_words.='\<package\>:\<endpackage\>,'
    let b:match_words.='\<function\>:\<endfunction\>,'
    let b:match_words.='\<task\>:\<endtask\>,'
    let b:match_words.='\<case\>:\<endcase\>,'
    let b:match_words.='\<fork\>:\<join\w*,'
endfunction
function! common#matchseps(c,s)
	for a:item in a:s
		if a:item==a:c
			return 1
		endif
	endfor
	return 0
endfunction
function! common#getSelectedWord(sep)
	let a:line    = getline('.')
	let a:currpos = col('.')-1
	let a:idx = a:currpos
	if common#matchseps(a:line[a:currpos],a:sep)==1
		return ''
	endif
	while a:idx > 0
		let a:char = a:line[a:idx]
		if common#matchseps(a:char,a:sep)==1
			let a:idx += 1 " if matched sep, need skip that sep
			break
		endif
		let a:idx -= 1
	endwhile
	let a:prepos = a:idx
	let a:idx=a:currpos
	while a:idx < len(a:line)
		let a:char = a:line[a:idx]
		if common#matchseps(a:char,a:sep)==1
			break
		endif
		let a:idx += 1
	endwhile
	return a:line[a:prepos:a:idx-1]
endfunction
