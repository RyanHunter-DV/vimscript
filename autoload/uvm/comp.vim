
function! uvm#comp#createConnectPhase() " {
	let a:head = g:indentChar.'extern function void connect_phase(uvm_phase phase);'
	let a:body = []

	call uvm#common#getClassName()
	call add(a:body,'function void '.b:className.'::connect_phase(uvm_phase phase); // {')
	call add(a:body,g:indentChar.'super.build_phase(phase);')
	call add(a:body,'endfunction // }')
	call uvm#common#addMethodHead(a:head)
	call uvm#common#addMethodBody(a:body)
endfunction " }

function! uvm#comp#createBuildPhase() " {
	let a:buildHead = g:indentChar.'extern function void build_phase(uvm_phase phase);'
	let a:buildBody = []

	call uvm#common#getClassName()
	call add(a:buildBody,'function void '.b:className.'::build_phase(uvm_phase phase); // {')
	call add(a:buildBody,g:indentChar.'super.build_phase(phase);')
	call add(a:buildBody,'endfunction // }')

	call uvm#common#addMethodHead(a:buildHead)
	call uvm#common#addMethodBody(a:buildBody)

endfunction " }

function! uvm#comp#createRunPhase() " {
	let a:head = g:indentChar.'extern task run_phase(uvm_phase phase);'
	let a:body = []

	call uvm#common#getClassName()
	call add(a:body,'task '.b:className.'::run_phase(uvm_phase phase); // {')
	call add(a:body,g:indentChar.'super.run_phase(phase);')
	call add(a:body,'endtask // }')

	call uvm#common#addMethodHead(a:head)
	call uvm#common#addMethodBody(a:body)

endfunction " }
