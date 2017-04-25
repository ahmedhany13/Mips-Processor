module pc(clk,Pc,newPc);

input clk;
output [31:0] Pc;
output [31:0] newPc;


Pc = 32b'0;


initial begin
    Pc = 32'b00000000000000000000000000000000;
end

always @(clk)

begin

Pc = newPc;

end
