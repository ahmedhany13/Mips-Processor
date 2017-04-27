module mips(clk);


input clk;



// wires
// IF STAGE
wire[31:0]     IF_Pc  ;

wire[31:0]      IF_Mux_out , IF_newPc, IF_inc_pc ,theIF_insruction;

//ID stage

wire [31:0]  ID_instruction , ID_inc_pc ,ID_sign_extend ,ID_read_data_1 ,ID_read_data_2;
wire [4:0] ID_rs , ID_rd , ID_rt ,  ID_shamt  ;
wire [5:0]  ID_funct , ID_oppcode;
wire [15:0] ID_address;
wire  ID_regDes;
wire  ID_memoryRead;
wire  ID_branch;
wire  ID_memoryToReg;
wire  [1:0] ID_AluOp;
wire  ID_memoryWrite;
wire  ID_AluSrc;
wire  ID_regWrite;


//EX stage
wire  [31:0] EX_inc_pc,EX_read_data_1 ,EX_read_data_2,EX_mux_to_ALU_out,EX_add_out,EX_ALU_out,EX_sign_extend ;
wire  [4:0] EX_rd , EX_rt ,EX_mux_out,EX_shamt ;
wire  EX_regDes, EX_equal_flag,EX_not_equal_flag;
wire  EX_memoryRead;
wire  EX_branch;
wire  EX_memoryWrite;
wire  EX_memoryToReg;
wire  EX_regWrite;
wire  [1:0] EX_AluOp;
wire  EX_AluSrc;
wire [5:0]  EX_funct;
wire  [3:0] EX_ALU_control;


//MEM
wire MEM_memoryToReg;
wire MEM_equal_flag,MEM_not_equal_flag;
wire MEM_memoryRead;
wire MEM_branch;
wire MEM_regWrite;
wire MEM_memoryWrite;
wire MEM_equal_branch_res;
wire MEM_not_equal_branch_res;
wire MEM_pcSrc;
wire [31:0] MEM_ALU_out,MEM_read_data_2,MEM_read_data,MEM_add_out ;
wire [4:0] MEM_mux_out;


//WB

wire     WB_memoryToReg;
wire     WB_pcSrc;
wire     [31:0]  WB_read_data , WB_ALU_out, WB_write_data  ;
wire     [4:0] WB_mux_out;







// IF IMPLEMENTAION STAGE

mux         THE_MUX( clk , IF_inc_pc ,MEM_add_out,MEM_pcSrc, IF_Mux_out );

pc          IF_itsPc(clk,IF_Mux_out,IF_newPc);

Add         IF_add(clk, IF_newPc, 32'd1, IF_inc_pc);

instruction_Memory     IF_instrcution_mem(clk ,IF_newPc , theIF_insruction);


// IF/ID pipeline STAGE

iF_ID       IF_id(clk ,IF_inc_pc , ID_inc_pc , theIF_insruction , ID_instruction);


// ID IMPLEMENTAION STAGE


splitter    splt(clk ,ID_instruction,ID_oppcode , ID_rs , ID_rt , ID_rd ,ID_address, ID_funct, ID_shamt);

rf          regfile(clk ,ID_rs ,ID_rt, WB_mux_out , WB_write_data,WB_regWrite,ID_read_data_1,ID_read_data_2 );

Maincontroller   ctrl(clk ,ID_oppcode, ID_regDes, ID_branch , ID_memoryRead , ID_memoryToReg , ID_AluOp ,ID_memoryWrite,ID_AluSrc, ID_regWrite);


sign_extender    SignExt(clk, ID_address, ID_sign_extend);



// ID/EX  pipeline STAGE

 IDEX        id_ex(clk,IF_inc_pc,ID_read_data_1 ,ID_read_data_2,ID_sign_extend,ID_funct,
ID_rt,ID_rd, ID_AluOp, ID_regWrite, ID_memoryToReg,ID_branch,ID_memoryWrite,ID_memoryRead,ID_AluSrc,ID_regDes,
EX_inc_pc,EX_read_data_1,EX_read_data_2,EX_sign_extend,EX_funct,EX_rt,
EX_rd, EX_AluOp ,EX_regWrite,EX_memoryToReg, EX_branch,EX_memoryWrite,
EX_memoryRead,EX_AluSrc,EX_regDes );

//EX implementation stage
Add     add1(clk, EX_inc_pc, EX_sign_extend, EX_add_out);
mux     mux1(clk,EX_read_data_2 ,EX_sign_extend , EX_AluSrc, EX_mux_to_ALU_out);
mux5     mux2(clk,EX_rt ,EX_rd ,EX_regDes,EX_mux_out);
ALU     alu(clk, EX_ALU_out, EX_shamt, EX_equal_flag,EX_not_equal_flag,EX_read_data_1 ,EX_mux_to_ALU_out  ,EX_ALU_control);
ALU_controller   ctrt_alu(clk, EX_funct,EX_AluOp,EX_ALU_control);

// exe_mem
// EX/MEM pipelined stage

// main
EX_MEM   exe_mem(clk ,EX_regWrite, EX_memoryToReg, MEM_regWrite, MEM_memoryToReg, EX_branch,
EX_memoryRead, EX_memoryWrite, MEM_branch, MEM_memoryRead, MEM_memoryWrite, EX_equal, 
EX_not_equal, MEM_equal, MEM_not_equal, EX_add_out, MEM_add_out, EX_ALU_out, MEM_ALU_out,
EX_read_data_2, MEM_read_data_2, EX_mux_out, MEM_mux_out);



//MEM implementation stage

And_gate       and1(clk, MEM_branch, MEM_equal, MEM_equal_branch_res);

And_gate       and2(clk, MEM_branch, MEM_not_equal, MEM_not_equal_branch_res);

or_gate   or_1(clk, MEM_equal_branch_res , MEM_not_equal_branch_res, MEM_pcSrc);


data_Memory    DM(clk, MEM_ALU_out , MEM_read_data_2 , MEM_read_data , MEM_memoryWrite , MEM_memoryRead );

// MEM/WB  piplined stage

Mem_Wb       Mem_Wb(clk, MEM_ALU_out , WB_ALU_out , MEM_read_data , WB_read_data , MEM_mux_out , WB_mux_out  ,
                     MEM_memoryToReg ,WB_memoryToReg , MEM_pcSrc , WB_pcSrc );


// WB implemntaion stage

mux      mux4(clk, WB_read_data, WB_ALU_out, WB_memoryToReg, WB_write_data);



endmodule
