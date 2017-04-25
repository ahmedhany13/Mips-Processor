module sign_extender(in,out);
input [15:0] in;
output [31:0] out;

initial
begin
assign out[15:0]=in[15:0];
assign out[31:16]=1'b0;
end 

endmodule // sign_extender