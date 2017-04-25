module(opcode,regDes,branch,memoryRead,memoryToReg,AluOp,memoryWrite,AluSrc,regWrite);
input wire [5:0] opcode;
output wire regDes;
output wire branch-eq;
output wire branch-ne;
output wire memoryRead;
output wire memoryToReg;
output wire [1:0] AluOp;
output wire memoryWrite;
output wire AluSrc;
output wire regWrite;
always@(*) begin
//default values to avoid mix of control signals
AluOp[1:0]	<= 2'b10;
regDes	<= 1'b0;
branch	<= 1'b0;
memoryRead	<= 1'b0;
memoryToReg	<= 1'b0;
memoryWrite	<= 1'b0;
AluSrc	<= 1'b0;
regWrite	<= 1'b0;

case (opcode)
6'000000://r-type
begin
regDes <=1'b1;
regWrite <=1'b1;

end
6'b100011:begin//lw
AluOp <=2'b00;
 memoryRead <=1'b1;
 memoryToReg <=1'b1;
 AluSrc <=1'b1;
 regWrite <=1'b1;
          end
6'b101011:begin//sw
AluOp <=2'b00;
memoryWrite <=1'b1;
AluSrc <=1'b1;

        end
6'b001100:begin//andi
regWrite <=1'b1;
AluSrc <=1'b1;

        end
6'b001101:begin//ori
regWrite <=1'b1;
AluSrc <=1'b1;

        end
6'000100:begin//branch-eq
AluOp <=2'b01;
branch-eq <=1'b1;  

        end
  6'000101:begin//branch-ne
AluOp <=2'b01;
branch-ne <=1'b1;  

        end
  6'000100:begin//addi
regWrite <=1'b1;
AluSrc <=1'b1;

        end      
end
endcase
endmodule
