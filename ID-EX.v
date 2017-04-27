module IDEX(clk,pc_in, read_data1_in , read_data2_in, sign_extend_in, funct_in,
 rt_in, rd_in, ALUOp_in,regWrite_in, memoToReg_in,
 branch_in, memWrite_in, memRead_in, ALUSrc_in,
 RegDst_in, pc_out, read_data1_out , read_data2_out, sign_extend_out, funct_out,
 rt_out, rd_out, ALUOp_out,regWrite_out, memoToReg_out,
 branch_out, memWrite_out, memRead_out, ALUSrc_out,
 RegDst_out
 );

    input clk;
    input [31:0] pc_in, read_data1_in ,read_data2_in, sign_extend_in ;
    input [4:0] rt_in, rd_in;
    input [1:0] ALUOp_in;
    input [5:0] funct_in;
    input regWrite_in, memoToReg_in, branch_in, memWrite_in, memRead_in,
          ALUSrc_in, RegDst_in ;

    output reg [31:0] pc_out, read_data1_out , read_data2_out, sign_extend_out ;
    output reg [4:0] rt_out, rd_out;
    output reg [1:0] ALUOp_out;
    output reg [5:0] funct_out;
    output reg regWrite_out, memoToReg_out, branch_out, memWrite_out,
           memRead_out, ALUSrc_out, RegDst_out;


always @(posedge clk) begin
  pc_out = pc_in;
    read_data1_out=read_data1_in;
    read_data2_out=read_data2_in;
  sign_extend_out = sign_extend_in;
  rt_out = rt_in ;
  rd_out = rd_in ;
  ALUOp_out = ALUOp_in;
  regWrite_out = regWrite_in ;
  memoToReg_out = memoToReg_in;
  branch_out = branch_in;
  memWrite_out = memWrite_in;
  memRead_out = memRead_in;
  ALUSrc_out = ALUSrc_in;
  RegDst_out = RegDst_in;

end
endmodule // ID_EX
