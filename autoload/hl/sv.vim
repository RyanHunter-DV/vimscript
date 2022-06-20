let s:defmethod   = {'theme':{},'item':[]}
let s:dtype       = {'theme':{},'item':[]}
let s:buildblock  = {'theme':{},'item':[]}
let s:codeblock   = {'theme':{},'item':[]}
let s:selected    = {'theme':{},'item':[]}

function! hl#sv#SVdefmethodGroup()
	call extend(s:defmethod['item'],['function', 'endfunction', 'task', 'endtask'])
	let a:words = join(s:defmethod['item'],' ')
	execute printf("syn keyword dshl_defmethod %s",a:words)
endfunction

function! hl#sv#SVbuildblockGroup()
	call extend(s:buildblock['item'],['module','endmodule','program','endprogram'])
	call extend(s:buildblock['item'],['package','endpackage','clocking','endclocking'])
	call extend(s:buildblock['item'],['class','endclass','this','super'])
	let a:words = join(s:buildblock['item'],' ')
	execute printf("syn keyword dshl_buildblock %s",a:words)
endfunction
function! hl#sv#SVcodeblockGroup()
	call extend(s:codeblock['item'],['always','always_comb','always_ff','always_latch'])
	call extend(s:codeblock['item'],['begin','end','fork','join','join_none','join_any'])
	let a:words = join(s:codeblock['item'],' ')
	execute printf("syn keyword dshl_codeblock %s",a:words)
endfunction

function! hl#sv#SVdtypeGroup()
	call extend(s:dtype['item'],['void','bit','byte','enum','logic'])
	call extend(s:dtype['item'],['shortint', 'int', 'longint'])
	call extend(s:dtype['item'],['shortreal', 'real'])

	let a:words = join(s:dtype['item'],' ')
	execute printf("syn keyword dshl_dtype %s",a:words)
endfunction

function! s:DefineSyntax()
	call hl#sv#SVdtypeGroup()
	call hl#sv#SVbuildblockGroup()
	call hl#sv#SVcodeblockGroup()
	call hl#sv#SVdefmethodGroup()
endfunction

function! s:LoadDefaultTheme() "{
	let s:defmethod['theme']  = ['gui=bold guifg=#1589ff']
	let s:dtype['theme']      = ['gui=bold guifg=#43c6db']
	let s:buildblock['theme'] = ['gui=bold guifg=#f75d59']
	let s:codeblock['theme']  = ['gui=bold guifg=#00ced1']
	let s:selected['theme']   = ['guifg=#000000 guibg=#c04000']
endfunction "}

function! hl#sv#loadtheme() "{
	call s:LoadDefaultTheme()
	call s:DefineSyntax()
	let a:theme = hl#theme#create()
	call a:theme.addGroup('dshl_defmethod',s:defmethod['theme'])
	call a:theme.addGroup('dshl_dtype', s:dtype['theme'])
	call a:theme.addGroup('dshl_buildblock', s:buildblock['theme'])
	call a:theme.addGroup('dshl_codeblock', s:codeblock['theme'])
	call a:theme.addGroup('dshl_selected', s:selected['theme'])
	call a:theme.render()
endfunction "}

let b:dshl_selected_defined = 0
function! hl#sv#SVselectedGroup(src)
	let a:words = a:src
	let b:dshl_selected_defined = 1
	echo a:words
	execute printf("syn keyword dshl_selected %s",a:words)
endfunction

function! hl#sv#moveselection()
	let a:sep = [',','.','#',' ','(',')',"\t",'[',']','\','=','`',';',':']
	let a:word = common#getSelectedWord(a:sep)
	if b:dshl_selected_defined==1
		execute 'syntax clear dshl_selected'
	endif
	echo "a:word ".a:word
	if a:word == ''
		return
	endif
	call hl#sv#SVselectedGroup(a:word)
endfunction
