let s:Theme={'groups':{}}
"let g:hlTheme = s:Theme
function!  s:Theme.New()
	let a:newObj = copy(self)
	return a:newObj
endfunction

function! s:Theme.addGroup(name,group)
	let self.groups[a:name] = a:group
endfunction

function! s:Theme.render()
	let a:keys   = keys(self.groups)
	for a:gn in a:keys
		let a:s = join(self.groups[a:gn],' ')
		execute printf("hi %s %s",a:gn,a:s)
	endfor
endfunction

function! hl#theme#create()
	return s:Theme.New()
endfunction
