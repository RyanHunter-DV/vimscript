" added for debug mode
set runtimepath+=/home/ryan/prj/GitHub/vimscript


function! ImportPlugin(n)
	echo printf("source %s",a:n)
endfunction


command! -nargs=1 Import call ImportPlugin('<args>')


command! UVM call uvm#import()


