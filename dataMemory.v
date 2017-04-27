module data_Memory(clk, address , writeData , readData , regWrite , regRead );
input  clk;
output reg [31:0] readData;
input  [31:0] address;
input  [31:0] writeData;
input  regRead;
input  regWrite;

//the memory
reg [31:0] memo [511:0];
integer n;

  assign offset = address[6:2];


initial
begin
  //emla el memo kolha b zero
  for (n=0 ;n<511 ;n++ ) begin
    memo[n]=32'b00000000000000000000000000000000;
  end
end

//pstive wla negative
always @(posedge clk) begin
    if (regRead) begin
      readData=memo[address];
    end
    if (regWrite) begin
      memo[offset] =writeData;
    end
end


endmodule
