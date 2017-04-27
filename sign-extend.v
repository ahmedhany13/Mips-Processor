module sign_extender(clk, in, out);
input clk;
input [15:0] in;
output reg [31:0] out;

always@(posedge clk) begin

 out[31:16]=1'b0;
 out[15:0]=in[15:0];

end 

endmodule // sign_extender