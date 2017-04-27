module And (clk, In1, In2, out);
input clk;
input  In1, In2;
output  out;

assign out = In1 & In2;


endmodule


module Add (clk, In1, In2, out);
input clk;
input  In1, In2;
output  out;

assign out = In1 + In2;


endmodule

module or_gate(clk, in1 , in2, out);
input clk;
input in1,in2;
output  out;

assign out = (in1 | in2);

endmodule