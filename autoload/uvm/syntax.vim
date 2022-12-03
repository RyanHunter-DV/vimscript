
function! uvm#syntax#siftSingleComment(cnts)
	let l:sifted = []
	for l:line in a:cnts
		let l:len = len(l:line)
		let l:m = matchstrpos(l:line,'//')
		if l:m[0]=="" && l:m[1]==-1 && l:m[2]==-1
			call add(l:sifted,l:line)
		else
			" if matched from pos 0, then skip current line, else
			" skip the contents after // only
			if l:m[1]!=0
				call add(l:sifted,l:line[0:l:m[1]-1])
			endif
		endif
	endfor
	return l:sifted
endfunction

function! uvm#syntax#siftMultComment(cnts)
	let l:sifted=[]
	let l:rawstr = join(a:cnts,"\n")
	let l:str = substitute(l:rawstr,'\/\*[^\*\/]*\*\/','','g')
	let l:sifted = split(l:str,"\n")
	return l:sifted
endfunction

function! uvm#syntax#siftComment(cnts)
	let l:sifted = []
	let l:sifted = uvm#syntax#siftSingleComment(a:cnts)
	let l:sifted = uvm#syntax#siftMultComment(l:sifted)
	return l:sifted
endfunction

function! uvm#syntax#loadContents()
	let l:rawCnts = getline(1,'$')
	return uvm#syntax#siftComment(l:rawCnts)
endfunction

function! uvm#syntax#getClassName()
	for l:item in b:siftedCnts
		let l:m = matchlist(l:item,'^\w* *class \+\(\w\+\)[;| |#]')
		if !empty(l:m)
			return l:m[1]
		endif
	endfor
	return ""
endfunction



