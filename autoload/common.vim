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
	return a:line[a:prepos+1:a:idx-1]
endfunction
