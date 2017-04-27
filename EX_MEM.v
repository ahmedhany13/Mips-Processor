module EX_MEM(clk ,EX_Reg_Write ,EX_MemtoReg,MEM_Reg_Write, MEM_MemtoReg ,  EX_Branch, EX_Read, EX_Write , MEM_Branch , MEM_Read ,MEM_Write,EX_equal,EX_not_equal,MEM_equal,MEM_not_equal,EX_branch_add ,MEM_branch_add, EX_ALU_add ,MEM_ALU_add,EX_reg_value ,MEM_reg_value ,EX_write_reg,MEM_write_reg);
input clk;
input [31:0] EX_branch_add ,EX_ALU_add ,EX_reg_value;
input EX_equal,EX_not_equal ;
input [4:0]  EX_write_reg ;
input EX_Reg_Write,EX_MemtoReg,EX_Branch,EX_Read,EX_Write;
output reg [31:0]  MEM_ALU_add ,MEM_reg_value, MEM_branch_add;
output reg MEM_equal ,MEM_not_equal ;
output reg [4:0]  MEM_write_reg ;
output reg MEM_Branch , MEM_Read , MEM_Write,MEM_Reg_Write,MEM_MemtoReg ;


always @(posedge clk)

begin

MEM_Reg_Write = EX_Reg_Write;
MEM_MemtoReg = EX_MemtoReg;
MEM_Branch = EX_Branch;
MEM_branch_add=EX_branch_add;
MEM_Read = EX_Read;
MEM_equal=EX_equal;
MEM_not_equal=EX_not_equal;
MEM_Write = EX_Write;
MEM_ALU_add = EX_ALU_add;
MEM_reg_value = EX_reg_value;
MEM_write_reg = EX_write_reg;

end

endmodule
