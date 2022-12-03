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
	for l:item in a:s
		if l:item==a:c
			return 1
		endif
	endfor
	return 0
endfunction
function! common#getSelectedWord(sep)
	let l:line    = getline('.')
	let l:currpos = col('.')-1
	let l:idx = l:currpos
	if common#matchseps(l:line[l:currpos],a:sep)==1
		return ''
	endif
	while l:idx > 0
		let l:char = l:line[l:idx]
		if common#matchseps(l:char,a:sep)==1
			let l:idx += 1 " if matched sep, need skip that sep
			break
		endif
		let l:idx -= 1
	endwhile
	let l:prepos = l:idx
	let l:idx=l:currpos
	while l:idx < len(l:line)
		let l:char = l:line[l:idx]
		if common#matchseps(l:char,a:sep)==1
			break
		endif
		let l:idx += 1
	endwhile
	return l:line[l:prepos:l:idx-1]
endfunction
