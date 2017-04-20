module instruction_Memory (clk, address, pc, instruction);

input [31:0] pc, address;
input clk;
output [31:0] instruction;

always @(posedge clk) begin
  //go to the instruction 
  
end

endmodule