module mips(clk);


input clk;



// wires
// IF STAGE
wire[31:0]     IF_Pc  ;

reg[31:0]      IF_Mux_out , IF_newPc, IF_inc_pc ,theIF_insruction;

//ID stage

reg[31:0]  ID_instruction , ID_inc_pc ,ID_sign_extend ,ID_read_data_1 ,ID_read_data_2;

reg[4:0] ID_rs , ID_rd , ID_rt ,  ID_shamt  ;
reg[5:0]  ID_funct , ID_oppcode;
reg[15:0] ID_address;
reg ID_regDes;
reg ID_memoryRead;
reg ID_branch;
reg ID_memoryToReg;
reg [1:0] ID_AluOp;
reg ID_memoryWrite;
reg ID_AluSrc;
reg ID_regWrite;


//EX stage
reg [31:0] EX_inc_pc,EX_read_data_1 ,EX_read_data_2,EX_mux_to_ALU_out,EX_add_out,EX_ALU_out,EX_sign_extend ;
reg [4:0] EX_rd , EX_rt ,EX_mux_out,EX_shamt ;
reg EX_regDes, EX_equal_flag,EX_not_equal_flag;
reg EX_memoryRead;
reg EX_branch;
reg EX_memoryWrite;
reg EX_memoryToReg;
reg EX_regWrite;
reg [1:0] EX_AluOp;
reg EX_AluSrc;
reg[5:0]  EX_funct;
reg [3:0] EX_ALU_control;


//MEM
reg MEM_memoryToReg;
reg MEM_equal_flag,MEM_not_equal_flag;
reg MEM_memoryRead;
reg MEM_branch;
reg MEM_regWrite;
reg MEM_memoryWrite;
reg MEM_equal_branch_res;
reg MEM_not_equal_branch_res;
reg MEM_pcSrc;
reg [31:0] MEM_ALU_out,MEM_read_data_2,MEM_read_data,MEM_add_out ;
reg [4:0] MEM_mux_out;


//WB

reg WB_memoryToReg;
reg WB_pcSrc;
reg [31:0]  WB_read_data , WB_ALU_out, WB_write_data  ;
reg [4:0] WB_mux_out;







// IF IMPLEMENTAION STAGE

mux         IF_MUX( clk , IF_inc_pc ,MEM_add_out,MEM_pcSrc, IF_Mux_out );

pc          IF_Pc(clk,IF_Mux_out,IF_newPc);

Add         IF_add(IF_newPc,32'd4,IF_inc_pc);

instruction_Memory     IF_instrcution_mem(clk ,IF_newPc , theIF_insruction);


// IF/ID pipeline STAGE

iF_ID       IF_id(clk ,IF_inc_pc , ID_inc_pc , theIF_insruction , ID_insruction);


// ID IMPLEMENTAION STAGE



splitter    splt(clk ,ID_insruction,ID_oppcode , ID_rs , ID_rt , ID_rd ,ID_address, ID_funct, ID_shamt);

rf          regfile(clk ,ID_rs ,ID_rt, WB_mux_out , WB_write_data,WB_regWrite,ID_read_data_1,ID_read_data_2 );

Maincontroller   ctrl(clk ,ID_oppcode, ID_regDes, ID_branch , ID_memoryRead , ID_memoryToReg , ID_AluOp ,ID_memoryWrite,ID_AluSrc, ID_regWrite);


sign_extender    SignExt(clk, ID_address,out , ID_sign_extend);



// ID/EX  pipeline STAGE

 IDEX        id_ex(clk,IF_inc_pc,ID_read_data_1 ,ID_read_data_2,ID_sign_extend,ID_funct,
ID_rt,ID_rd, ID_AluOp, ID_regWrite, ID_memoryToReg,ID_branch,ID_memoryWrite,ID_memoryRead,ID_AluSrc,ID_regDes,
EX_inc_pc,EX_read_data_1,EX_read_data_2,EX_sign_extend,EX_funct,EX_rt,
EX_rd, EX_AluOp ,EX_regWrite,EX_memoryToReg, EX_branch,EX_memoryWrite,
EX_memoryRead,EX_AluSrc,EX_regDes );

//EX implementation stage
Add     add1(clk,EX_inc_pc ,EX_sign_extend,EX_add_out);
mux     mux1(clk,EX_read_data_2 ,EX_sign_extend , EX_AluSrc, EX_mux_to_ALU_out);
mux     mux2(clk,EX_rt ,EX_rd ,EX_regDes,EX_mux_out);
ALU     alu(clk, EX_ALU_out, EX_shamt, EX_equal_flag,EX_not_equal_flag,EX_read_data_1 ,EX_mux_to_ALU_out  ,EX_ALU_control);
ALU_controller   ctrt_alu(clk, EX_funct,EX_AluOp,EX_ALU_control);


// EX/MEM pipelined stage


EX_MEM   ex_mem(clk ,EX_regWrite,EX_memoryToReg,MEM_regWrite ,MEM_memoryToReg ,
EX_branch,EX_memoryRead,EX_memoryWrite,MEM_branch,MEM_memoryRead,MEM_memoryWrite
,EX_equal,EX_not_equal,MEM_equal,MEM_not_equal,EX_add_out,MEM_add_out ,EX_ALU_out,MEM_ALU_out
,EX_read_data_2,MEM_read_data_2 , EX_mux_out, MEM_mux_out );



//MEM implementation stage

And       and1(clk, MEM_branch, MEM_equal, MEM_equal_branch_res);

And       and1(clk, MEM_branch, MEM_not_equal, MEM_not_equal_branch_res);

or_gate   or_1(clk, MEM_equal_branch_res , MEM_not_equal_branch_res, MEM_pcSrc);


data_Memory    DM(clk, MEM_ALU_out , MEM_read_data_2 , MEM_read_data , MEM_memoryWrite , MEM_memoryRead );

// MEM/WB  piplined stage

Mem_Wb       Mem_Wb (clk, MEM_ALU_out , WB_ALU_out , MEM_read_data ,
 WB_read_data , MEM_regWrite , WB_regWrite  ,
 MEM_memoryToReg ,WB_memoryToReg , MEM_pcSrc , WB_pcSrc );


// WB implemntaion stage

mux      mux4(clk, WB_read_data, WB_ALU_out, WB_memoryToReg, WB_write_data);



endmodule
