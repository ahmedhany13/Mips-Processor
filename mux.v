module (in1, in2, selector, out);
input in1,in2,selector;
output out;


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