command! Build   call uvm#comp#createBuildPhase()
command! Connect call uvm#comp#createConnectPhase()
command! Run     call uvm#comp#createRunPhase()
command! FH      call uvm#common#addfileheader()
command! -nargs=* Func call uvm#common#createFunction(<f-args>)
command! -nargs=* Task call uvm#common#createTask(<f-args>)



aug autogroupUVM
au! InsertLeave *.sv,*.svh : let b:siftedCnts = uvm#syntax#loadContents()
aug END
