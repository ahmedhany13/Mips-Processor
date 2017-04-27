module pc(clk,Pc,newPc);

input clk;
output reg [31:0] Pc;
output reg [31:0] newPc;

initial begin
    Pc = 32'b00000000000000000000000000000000;
end

always @(clk)

begin

Pc = newPc;

end

endmodule
