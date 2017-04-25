module ALU (OUT, ZeroFlag, In1, In2, ALUOP);
input [31:0] In1, In2;
input [2:0] ALUOP;
output reg [31:0] OUT;
output   ZeroFlag;
always @ (In1, In2, ALUOP)
begin
if (In1 == In2)
ZeroFlag = 1;
else
ZeroFlag = 0;
end
always @ (In1, In2, ALUOP)
begin
case (ALUOP)
4'b0010 : OUT = In1 + In2;
4'b0110 : OUT = In1 - In2;
4'b0000 : OUT = In1 & In2;
4'b1000 : OUT = In1 << In2;
4'b1001 : OUT = In1 >> In2;
4'b0001 : OUT = In1 | In2;
4'b0111 : OUT = In1 < In2;
endcase
end
endmodule
