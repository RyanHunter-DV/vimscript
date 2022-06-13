`ifndef debug__svh
`define debug__svh

class testDriver #(type REQ=uvm_sequence_item,RSP=REQ) extends uvm_driver#(REQ,RSP);


	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void build_phase(uvm_phase phase);


endclass

function void testDriver::connect_phase(uvm_phase phase); // {
	super.build_phase(phase);
endfunction // }

task testDriver::run_phase(uvm_phase phase); // {
	super.run_phase(phase);
endtask // }

function void testDriver::build_phase(uvm_phase phase); // {
	super.build_phase(phase);
endfunction // }

`endif
