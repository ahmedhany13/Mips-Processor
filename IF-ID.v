module iF_ID(clk, IF_inc_pc , ID_inc_pc , IF_instruction , ID_instruction);

input [31:0] IF_inc_pc , IF_instruction  ;
input clk;
output reg [31:0] ID_inc_pc ,ID_instruction;

always @(clk)

begin
  ID_instruction = IF_instruction;
  ID_inc_pc = IF_inc_pc;
end
endmodule
