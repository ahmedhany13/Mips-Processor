module instruction_Memory (clk,address, instruction);
input clk;
input [31:0] address;
output reg [31:0] instruction;

reg [31:0] memo [511:0];


//  Arithmetic: add, sub, addi
//  Load/Store: lw, sw
//  Logic: and, or, sll, srl, andi, ori
//  Control flow: beq, bne
//  Comparison: slt
initial
begin
memo[0]=32'h22310000;
memo[1]=32'h2008004b;
memo[2]=32'h014a6020;
memo[3]=32'h08100007;
end

always @(address)
begin
  //go to the instruction
  instruction=memo[address];
end

endmodule
