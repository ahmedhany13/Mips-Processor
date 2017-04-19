module Add (Out , In1 , In2);

 input [31:0] In1, In2;
 output reg [31:0] OUT;

always @ (In1, In2)
begin
Out = In1 + In2; 
end
endmodule
