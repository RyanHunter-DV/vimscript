let s:defmethod   = {'theme':{},'item':[]}
let s:dtype       = {'theme':{},'item':[]}
let s:buildblock  = {'theme':{},'item':[]}
let s:codeblock   = {'theme':{},'item':[]}
let s:selected    = {'theme':{},'item':[]}
let s:builtin     = {'theme':{},'item':[]}
let s:qualify     = {'theme':{},'item':[]}
let s:loop        = {'theme':{},'item':[]}
let s:condition   = {'theme':{},'item':[]}

function! hl#sv#SVdefmethodGroup()
	call extend(s:defmethod['item'],['function', 'endfunction', 'task', 'endtask'])
	let l:words = join(s:defmethod['item'],' ')
	" execute printf("syntax clear dshl_defmethod")
	execute printf("syn keyword dshl_defmethod %s",l:words)
endfunction

function! hl#sv#SVbuildblockGroup()
	call extend(s:buildblock['item'],['module','endmodule','program','endprogram'])
	call extend(s:buildblock['item'],['package','endpackage','clocking','endclocking'])
	call extend(s:buildblock['item'],['class','endclass'])
	let l:words = join(s:buildblock['item'],' ')
	" execute printf("syntax clear dshl_buildblock")
	execute printf("syn keyword dshl_buildblock %s",l:words)
endfunction
function! hl#sv#SVcodeblockGroup()
	call extend(s:codeblock['item'],['always','always_comb','always_ff','always_latch'])
	call extend(s:codeblock['item'],['begin','end','fork','join','join_none','join_any'])
	let l:words = join(s:codeblock['item'],' ')
	" execute printf("syntax clear dshl_codeblock")
	execute printf("syn keyword dshl_codeblock %s",l:words)
endfunction

function! hl#sv#SVconditionGroup()
	call extend(s:condition['item'],['if','else','break','continue','case','endcase','default'])
	let l:words = join(s:condition['item'],' ')
	" execute printf("syntax clear dshl_condition")
	execute printf("syn keyword dshl_condition %s",l:words)
endfunction

function! hl#sv#SVloopGroup()
	call extend(s:loop['item'],['for','while','do','foreach'])
	let l:words = join(s:loop['item'],' ')
	" execute printf("syntax clear dshl_loop")
	execute printf("syn keyword dshl_loop %s",l:words)
endfunction

function! hl#sv#SVdtypeGroup()
	call extend(s:dtype['item'],['void','bit','byte','enum','logic'])
	call extend(s:dtype['item'],['shortint', 'int', 'longint'])
	call extend(s:dtype['item'],['shortreal', 'real','parameter','defparam','localparam'])

	let l:words = join(s:dtype['item'],' ')
	" execute printf("syntax clear dshl_dtype")
	execute printf("syn keyword dshl_dtype %s",l:words)
endfunction
function! hl#sv#SVbuiltinGroup()
	call extend(s:builtin['item'],['new','push_back','push_front','pop_front','pop_back'])
	call extend(s:builtin['item'],['null','return'])

	let l:words = join(s:builtin['item'],' ')
	" execute printf("syntax clear dshl_builtin")
	execute printf("syn keyword dshl_builtin %s",l:words)
endfunction
function! hl#sv#SVqualifyGroup()
	call extend(s:qualify['item'],['extern','this','super','virtual','static','const'])
	call extend(s:qualify['item'],['pure'])

	let l:words = join(s:qualify['item'],' ')
	" execute printf("syntax clear dshl_builtin")
	execute printf("syn keyword dshl_qualify %s",l:words)
endfunction

function! s:DefineSyntax()
	call hl#sv#SVdtypeGroup()
	call hl#sv#SVbuildblockGroup()
	call hl#sv#SVcodeblockGroup()
	call hl#sv#SVconditionGroup()
	call hl#sv#SVloopGroup()
	call hl#sv#SVdefmethodGroup()
	call hl#sv#SVbuiltinGroup()
	call hl#sv#SVqualifyGroup()
endfunction

function! s:LoadDefaultTheme() "{
	let s:defmethod['theme']  = ['gui=bold guifg=#1589ff']
	let s:dtype['theme']      = ['gui=bold guifg=#ffffc2']
	let s:buildblock['theme'] = ['gui=bold guifg=#f75d59']
	let s:codeblock['theme']  = ['gui=bold guifg=#00ced1']
	let s:selected['theme']   = ['guifg=#000000 guibg=#c04000']
	let s:builtin['theme']    = ['gui=bold guifg=#32cd32']
	let s:qualify['theme']    = ['guifg=#95b9c7']
	let s:loop['theme']       = ['gui=bold guifg=#6afb92']
	let s:condition['theme']  = ['gui=bold guifg=#f75d59']
endfunction "}

function! hl#sv#loadtheme() "{
	let b:dshl_selected_defined = 0
	call s:LoadDefaultTheme()
	call s:DefineSyntax()
	let l:theme = hl#theme#create()
	call l:theme.addGroup('dshl_defmethod',s:defmethod['theme'])
	call l:theme.addGroup('dshl_dtype', s:dtype['theme'])
	call l:theme.addGroup('dshl_buildblock', s:buildblock['theme'])
	call l:theme.addGroup('dshl_codeblock', s:codeblock['theme'])
	call l:theme.addGroup('dshl_selected', s:selected['theme'])
	call l:theme.addGroup('dshl_builtin', s:builtin['theme'])
	call l:theme.addGroup('dshl_qualify', s:qualify['theme'])
	call l:theme.addGroup('dshl_loop', s:loop['theme'])
	call l:theme.addGroup('dshl_condition', s:condition['theme'])
	call l:theme.render()
endfunction "}

function! hl#sv#SVselectedGroup(src)
	let l:words = a:src
	let b:dshl_selected_defined = 1
	echo l:words
	execute printf("syn keyword dshl_selected %s",l:words)
endfunction

function! hl#sv#moveselection()
	let l:sep = [',','.','#',' ','(',')',"\t",'[',']','\','=','`',';',':']
	let l:word = common#getSelectedWord(l:sep)
	if b:dshl_selected_defined==1
		execute 'syntax clear dshl_selected'
	endif
	echo "l:word ".l:word
	if l:word == ''
		return
	endif
	call hl#sv#SVselectedGroup(l:word)
endfunction
