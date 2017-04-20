module Add (In1, In2, out);

input [31:0] In1, In2;
output reg [31:0] out;

always @(In1, In2) begin
   out = In1 + In2; 

end

endmodule