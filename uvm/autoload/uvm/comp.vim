let g:indentChar = "\t"

function! uvm#comp#createConnectPhase()
endfunction

function! uvm#comp#createBuildPhase()
	let a:currentLine = uvm#common#getCurrentLine()
	let a:endClassLine= uvm#common#getEndClassLine()
	let a:buildHead = g:indentChar.'extern function void build_phase(uvm_phase phase);'
	let a:buildBody = []

	echo "current line: ".a:currentLine
	echo "endClassLine: ".a:endClassLine
	call uvm#common#getClassName()
	echo 'getClassName '.b:className
	if b:className=='null'
		echo "Error, no class name defined"
		return
	endif

	call add(a:buildBody,'function void '.b:className.'::build_phase(uvm_phase phase); // {')
	call add(a:buildBody,g:indentChar.'super.build_phase(phase);')
	call add(a:buildBody,'endfunction // }')

	call append(a:currentLine,a:buildHead)
	let a:endClassLine+=1
	let a:idx=0

	" add blank line
	call append(a:endClassLine+a:idx,'')
	let a:idx+=1

	for a:item in a:buildBody
		call append(a:endClassLine+a:idx,a:item)
		let a:idx+=1
	endfor

endfunction
