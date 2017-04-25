module data_Memory(address , writeData , readData , regWrite , regRead );

output [31:0] readData;
input  [31:0] address;
input  [31:0] writeData;
input  regRead;
input  regWrite;

//the memory
reg [31:0] memo [511:0];
integer n;

initial
begin
  //emla el memo kolha b zero
  for (n=0 ;n<511 ;n++ ) begin
    memo[n]=32b'00000000000000000000000000000000;
  end
end

//pstive wla negative السير فاهدو يتسأل
always @(address) begin
    if (regRead) begin
      readData<=memo[address];
    end
    if (regWrite) begin
      memo[address] <=writeData;
    end
end


endmodule
