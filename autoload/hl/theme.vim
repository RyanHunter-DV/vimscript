let s:Theme={'groups':{}}
"let g:hlTheme = s:Theme
function!  s:Theme.New()
	let l:newObj = copy(self)
	return l:newObj
endfunction

function! s:Theme.addGroup(name,group)
	let self.groups[a:name] = a:group
endfunction

function! s:Theme.render()
	let l:keys   = keys(self.groups)
	for l:gn in l:keys
		let l:s = join(self.groups[l:gn],' ')
		execute printf("hi %s %s",l:gn,l:s)
	endfor
endfunction

function! hl#theme#create()
	return s:Theme.New()
endfunction
