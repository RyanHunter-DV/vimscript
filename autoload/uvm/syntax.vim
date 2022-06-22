
function! uvm#syntax#siftSingleComment(cnts)
	let a:sifted = []
	for a:line in a:cnts
		let a:len = len(a:line)
		let a:m = matchstrpos(a:line,'//')
		if a:m[0]=="" && a:m[1]==-1 && a:m[2]==-1
			call add(a:sifted,a:line)
		else
			" if matched from pos 0, then skip current line, else
			" skip the contents after // only
			if a:m[1]!=0
				call add(a:sifted,a:line[0:a:m[1]-1])
			endif
		endif
	endfor
	return a:sifted
endfunction

function! uvm#syntax#siftMultComment(cnts)
	let a:sifted=[]
	let a:rawstr = join(a:cnts,"\n")
	let a:str = substitute(a:rawstr,'\/\*[^\*\/]*\*\/','','g')
	let a:sifted = split(a:str,"\n")
	return a:sifted
endfunction

function! uvm#syntax#siftComment(cnts)
	let a:sifted = []
	let a:sifted = uvm#syntax#siftSingleComment(a:cnts)
	let a:sifted = uvm#syntax#siftMultComment(a:sifted)
	return a:sifted
endfunction

function! uvm#syntax#loadContents()
	let a:rawCnts = getline(1,'$')
	return uvm#syntax#siftComment(a:rawCnts)
endfunction

function! uvm#syntax#getClassName()
	for a:item in b:siftedCnts
		let a:m = matchlist(a:item,'^ *class \+\(\w\+\)[;| |#]')
		if !empty(a:m)
			return a:m[1]
		endif
	endfor
	return ""
endfunction



