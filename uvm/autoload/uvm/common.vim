function! uvm#common#getCurrentLine()
	let a:pos = getcurpos()
	return a:pos[1]
endfunction

function! uvm#common#getEndClassLine()
	echo "placeholder, TODO"
	let a:cnts = b:siftedCnts
	let a:lnum = 1
	for a:line in a:cnts
		if matchstr(a:line,'endclass') != ""
			break
		endif
		let a:lnum += 1
	endfor
	if a:lnum > len(a:cnts)
		return 0
	else
		return a:lnum
	endif
endfunction

function! uvm#common#getClassName()
	let b:className = uvm#syntax#getClassName()
endfunction
