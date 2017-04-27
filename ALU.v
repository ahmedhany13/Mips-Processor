module ALU (clk, OUT,shamt, equal,notEqual ,In1, In2, ALUOP);
input clk;
input [31:0] In1, In2;
input [3:0] ALUOP;
input [4:0] shamt;

output reg [31:0] OUT;
output  reg equal,notEqual;

always @ (In1, In2, ALUOP)
begin
if (In1 == In2)
begin
equal = 1;
notEqual = 0;
end
else
begin
notEqual = 1;
equal = 0;
end
end
always @ (In1, In2, ALUOP)
begin
case (ALUOP)
4'b0010 : OUT = In1 + In2;
4'b0110 : OUT = In1 - In2;
4'b0000 : OUT = In1 & In2;
4'b1000 : OUT = In2 << shamt;
4'b1001 : OUT = In2 >> shamt;
4'b0001 : OUT = In1 | In2;
4'b0111 : OUT = In1 < In2;
endcase
end
endmodule
