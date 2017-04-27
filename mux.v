module mux (clk, in1, in2, selector, out);
input clk;
input [31:0] in1 ;
input [31:0] in2 ;
input selector;
output reg [31:0] out;


always @(in1, in2) begin
      if (selector==1'b0) 
    begin
        out=in1;
    end
    
    if(selector==1'b1) 
    begin
    out=in2;
    end

end
endmodule // 


module mux5 (clk, in1, in2, selector, out);
input clk;
input [4:0] in1 ;
input [4:0] in2 ;
input selector;
output reg [4:0] out;


always @(in1, in2) begin
      if (selector==1'b0) 
    begin
        out=in1;
    end
    
    if(selector==1'b1) 
    begin
    out=in2;
    end

end
endmodule // 