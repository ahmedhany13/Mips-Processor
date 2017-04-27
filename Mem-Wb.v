module Mem_Wb (clk, MEM_aluresult ,WB_aluresult , MEM_memread , WB_memread , MEM_writereg , WB_writereg  , MEM_memtoreg ,WB_memtoreg , MEM_pcsrc , WB_pcsrc );

input [31:0] MEM_aluresult , MEM_memread  ;
input clk;
input [4:0]  MEM_writereg;
input  MEM_memtoreg , MEM_pcsrc ;
output reg [31:0] WB_aluresult , WB_memread;
output reg [4:0] WB_writereg;
output reg WB_memtoreg , WB_pcsrc;

always @(posedge clk)begin
  WB_aluresult = MEM_aluresult;
  WB_memread =  MEM_memread;
  WB_writereg = MEM_writereg;
  WB_memtoreg = MEM_memtoreg;
  WB_pcsrc = MEM_pcsrc;


end
endmodule
