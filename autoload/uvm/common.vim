function! uvm#common#getCurrentLine()
	let a:pos = getcurpos()
	return a:pos[1]
endfunction

function! uvm#common#getEndClassLine()
	let a:cnts = getline(1,'$') 
	let a:lnum = 1
	for a:line in a:cnts
		if matchstr(a:line,'^[ |\t]*endclass') != ""
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

function! uvm#common#addMethodHead(cnt)
	let a:currentLine = uvm#common#getCurrentLine()
	call append(a:currentLine,a:cnt)
endfunction

function! uvm#common#addMethodBody(cnts)
	let a:endclassLine = uvm#common#getEndClassLine()

	echo "endclass: ".a:endclassLine
	if b:className=='null'
		echo "Error, no class name defined"
		return
	endif
	" add blank line
	let a:idx=0
	call append(a:endclassLine+a:idx,'')
	let a:idx+=1

	for a:item in a:cnts
		call append(a:endclassLine+a:idx,a:item)
		let a:idx+=1
	endfor
endfunction

function! uvm#common#addfileheader()
	let a:fn = uvm#common#getFilename()
	let a:macro = substitute(a:fn,'\.','__','g')
	let a:cline = getcurpos()[1]
	call setline(a:cline,'`ifndef '.a:macro)
	call setline(a:cline+1,'`define '.a:macro)
	call setline(a:cline+2,'`endif')
endfunction

function! uvm#common#getFilename()
	let a:fline = execute('file')
	let a:m = matchlist(a:fline,'\"\(.\+\)\"')
	if !empty(a:m)
		return a:m[1]
	endif
endfunction

function! uvm#common#createFunction(fn,args,rtn) "{
	let a:head = g:indentChar.'extern function '.a:rtn.' '.a:fn.'('.a:args.');'
	let a:body = []

	call uvm#common#getClassName()
	call add(a:body,'function '.a:rtn.' '.b:className.'::'.a:fn.'('.a:args.'); // {')
	call add(a:body,g:indentChar.'// PLACEHOLDER, auto generated function, add content here')
	call add(a:body,'endfunction // }')

	call uvm#common#addMethodHead(a:head)
	call uvm#common#addMethodBody(a:body)
endfunction "}
function! uvm#common#createTask(fn,args) "{
	let a:head = g:indentChar.'extern task '.a:fn.'('.a:args.');'
	let a:body = []

	call uvm#common#getClassName()
	call add(a:body,'task '.b:className.'::'.a:fn.'('.a:args.'); // {')
	call add(a:body,g:indentChar.'// PLACEHOLDER, auto generated task, add content here')
	call add(a:body,'endtask // }')

	call uvm#common#addMethodHead(a:head)
	call uvm#common#addMethodBody(a:body)
endfunction "}
