" ability for uvm.vim
"
" import and initialize of uvm actions
function! uvm#import()
	call uvm#init()
endfunction


let b:className = 'null'
let b:siftedCnts = []

function! uvm#init()
	let b:siftedCnts = uvm#syntax#loadContents()
	runtime lib/cmds.vim
endfunction

