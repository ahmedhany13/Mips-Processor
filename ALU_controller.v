module ALU_controller (clk, funct, ALUOp, ALUSignal);
input clk;
input  [5:0] funct;
input  [1:0] ALUOp;
output reg  [3:0] ALUSignal;

always @ (/*funct,*/ ALUOp)
begin
    if (ALUOp==2'b00) begin
      ALUSignal=4'b0010;
    end
  
    if (ALUOp==2'b01) begin
      ALUSignal=4'b0110;
    end

//
    if (ALUOp==2'b10) begin
      case (funct)
      6'b000000 : ALUSignal = 4'b1000 ;//shift left logic
      6'b000010 : ALUSignal = 4'b1001 ;//shift right logic
      6'b100000 : ALUSignal = 4'b0010 ;//add
      6'b100010 : ALUSignal = 4'b0110 ;//subtract
      6'b100100 : ALUSignal = 4'b0000 ;//AND
      6'b100101 : ALUSignal = 4'b0001 ;//OR
      6'b101010 : ALUSignal = 4'b0111 ;//set-on-less-than
      
endcase
end

end
endmodule 