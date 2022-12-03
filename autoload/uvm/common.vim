function! uvm#common#getCurrentLine()
	let l:pos = getcurpos()
	return l:pos[1]
endfunction

function! uvm#common#getEndClassLine()
	let l:cnts = getline(1,'$') 
	let l:lnum = 1
	for l:line in l:cnts
		if matchstr(l:line,'^[ |\t]*endclass') != ""
			break
		endif
		let l:lnum += 1
	endfor
	if l:lnum > len(l:cnts)
		return 0
	else
		return l:lnum
	endif
endfunction

function! uvm#common#getClassName()
	let b:className = uvm#syntax#getClassName()
endfunction

function! uvm#common#addMethodHead(cnt)
	let l:currentLine = uvm#common#getCurrentLine()
	call append(l:currentLine,l:cnt)
endfunction

function! uvm#common#addMethodBody(cnts)
	let l:endclassLine = uvm#common#getEndClassLine()

	echo "endclass: ".l:endclassLine
	if b:className=='null'
		echo "Error, no class name defined"
		return
	endif
	" add blank line
	let l:idx=0
	call append(l:endclassLine+l:idx,'')
	let l:idx+=1

	for l:item in l:cnts
		call append(l:endclassLine+l:idx,l:item)
		let l:idx+=1
	endfor
endfunction

function! uvm#common#addfileheader()
	let l:fn = uvm#common#getFilename()
	let l:macro = substitute(l:fn,'\.','__','g')
	let l:cline = getcurpos()[1]
	call setline(l:cline,'`ifndef '.l:macro)
	call setline(l:cline+1,'`define '.l:macro)
	call setline(l:cline+2,'`endif')
endfunction

function! uvm#common#getFilename()
	let l:fline = execute('file')
	let l:m = matchlist(l:fline,'\"\(.\+\)\"')
	if !empty(l:m)
		return l:m[1]
	endif
endfunction

function! uvm#common#createFunction(fn,args,rtn) "{
	let l:head = g:indentChar.'extern function '.a:rtn.' '.a:fn.'('.a:args.');'
	let l:body = []

	call uvm#common#getClassName()
	call add(l:body,'function '.a:rtn.' '.b:className.'::'.a:fn.'('.a:args.'); // {')
	call add(l:body,g:indentChar.'// PLACEHOLDER, auto generated function, add content here')
	call add(l:body,'endfunction // }')

	call uvm#common#addMethodHead(l:head)
	call uvm#common#addMethodBody(l:body)
endfunction "}
function! uvm#common#createTask(fn,args) "{
	let l:head = g:indentChar.'extern task '.a:fn.'('.a:args.');'
	let l:body = []

	call uvm#common#getClassName()
	call add(l:body,'task '.b:className.'::'.a:fn.'('.a:args.'); // {')
	call add(l:body,g:indentChar.'// PLACEHOLDER, auto generated task, add content here')
	call add(l:body,'endtask // }')

	call uvm#common#addMethodHead(l:head)
	call uvm#common#addMethodBody(l:body)
endfunction "}
