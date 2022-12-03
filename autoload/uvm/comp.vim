
function! uvm#comp#createConnectPhase() " {
	let l:head = g:indentChar.'extern function void connect_phase(uvm_phase phase);'
	let l:body = []

	call uvm#common#getClassName()
	call add(l:body,'function void '.b:className.'::connect_phase(uvm_phase phase); // {')
	call add(l:body,g:indentChar.'super.connect_phase(phase);')
	call add(l:body,'endfunction // }')
	call uvm#common#addMethodHead(l:head)
	call uvm#common#addMethodBody(l:body)
endfunction " }

function! uvm#comp#createBuildPhase() " {
	let l:buildHead = g:indentChar.'extern function void build_phase(uvm_phase phase);'
	let l:buildBody = []

	call uvm#common#getClassName()
	call add(l:buildBody,'function void '.b:className.'::build_phase(uvm_phase phase); // {')
	call add(l:buildBody,g:indentChar.'super.build_phase(phase);')
	call add(l:buildBody,'endfunction // }')

	call uvm#common#addMethodHead(l:buildHead)
	call uvm#common#addMethodBody(l:buildBody)

endfunction " }

function! uvm#comp#createRunPhase() " {
	let l:head = g:indentChar.'extern task run_phase(uvm_phase phase);'
	let l:body = []

	call uvm#common#getClassName()
	call add(l:body,'task '.b:className.'::run_phase(uvm_phase phase); // {')
	call add(l:body,g:indentChar.'super.run_phase(phase);')
	call add(l:body,'endtask // }')

	call uvm#common#addMethodHead(l:head)
	call uvm#common#addMethodBody(l:body)

endfunction " }
