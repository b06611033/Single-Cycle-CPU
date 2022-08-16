module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;


wire [31:0] instruction;
wire [31:0] PC_nxt;
wire [31:0] PC_current;

wire [6:0] Op;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] func3;
wire [6:0] func7;
wire [11:0] imme_12bit;

wire [31:0] Databus1;    //for rs1
wire [31:0] Databus2;    //for rs2
wire [31:0] Databus3;    //for rd

wire [2:0] ALUCtrl;
wire [31:0] alu_in1;
wire [31:0] alu_in2;
wire [31:0] alu_out;
wire [1:0] ALUOp;
wire ALUSrc;

wire [31:0] imme;



assign Op = instruction[6:0];
assign rd = instruction[11:7];  
assign func3 = instruction[14:12];    
assign rs1 = instruction[19:15]; 
assign rs2 = instruction[24:20]; 
assign func7 = instruction[31:25];
assign imme_12bit = instruction[31:20];

assign Databus3 = alu_out;
assign alu_in1 = Databus1;




Control Control(
    .Op_i       (Op),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);



Adder Add_PC(
    .data1_in   (PC_current),
    .data2_in   (),
    .data_o     (PC_nxt)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PC_nxt),
    .pc_o       (PC_current)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC_current), 
    .instr_o    (instruction)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (rs1),
    .RS2addr_i   (rs2),
    .RDaddr_i   (rd), 
    .RDdata_i   (alu_out),
    .RegWrite_i (RegWrite), 
    .RS1data_o   (alu_in1), 
    .RS2data_o   (Databus2) 
);


MUX32 MUX_ALUSrc(
    .data1_i    (Databus2),
    .data2_i    (imme),
    .select_i   (ALUSrc),
    .data_o     (alu_in2)
);



Sign_Extend Sign_Extend(
    .data_i     (imme_12bit),
    .funct3_i   (func3),
    .data_o     (imme)
);

  

ALU ALU(
    .data1_i    (alu_in1),
    .data2_i    (alu_in2),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (alu_out),
    .Zero_o     ()
);



ALU_Control ALU_Control(
    .funct7_i   (func7),
    .funct3_i   (func3),  
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);


endmodule

