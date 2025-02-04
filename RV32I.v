module RV32I(
	input	wire			Clk,
	input	wire			Rst,
	output	wire	[31:0]	Instr,
	output	wire	[31:0]	Imm,
	output	wire	[31:0]	Result,
	output	wire	[31:0]	PC,
	output  wire            Testsign_01
	);
	
wire	[31:0]		Rs1;
wire	[31:0]		Rs2;
wire				PCAsrc;
wire				PCBsrc;
wire	[31:0]		DataOut;
wire				MemtoReg;
wire				RegWr;
wire	[2:0]		ExtOp;
wire				ALUAsrc;
wire	[1:0]		ALUBsrc;
wire	[3:0]		ALUctr;
wire	[2:0]		Branch;
wire				MemWr;
wire	[2:0]		MemOp;
wire				Zero;
wire				Less;
wire    [4:0]       Rd;

assign  Rd = Instr[11:7];

PC			RV32I_PC(
	.Clk(Clk),
	.Rst(Rst),
	.Imm(Imm),
	.Rs1(Rs1),
	.PCAsrc(PCAsrc),
	.PCBsrc(PCBsrc),
	.PC(PC)
	);
	
InstrMem	RV32I_InstrMem(
    .Rdclk(Clk),
	.Rdrst(Rst),
    .Rdaddr(PC),
    .Instr(Instr)
    );
	
RegFile		RV32I_RegFile(
	.Ra(Instr[19:15]),
	.Rb(Instr[24:20]),
	.Rw(Rd),
	.Result(Result),
	.DataOut(DataOut),
	.MemtoReg(MemtoReg),
	.RegWr(RegWr),
	.WrClk(Clk),
	.Rst(Rst),
	.BusA(Rs1),
	.BusB(Rs2),
	.Testsign_01(Testsign_01)
	);
	
ImmGen		RV32I_ImmGen(
	.Instr(Instr),
	.ExtOp(ExtOp),	
	.Imm(Imm)
	);
	
ContrGen	RV32I_ContrGen(
	.Instr(Instr),
	.ExtOp(ExtOp),
	.RegWr(RegWr),
	.ALUAsrc(ALUAsrc),
	.ALUBsrc(ALUBsrc),
	.ALUctr(ALUctr),
	.Branch(Branch),
	.MemtoReg(MemtoReg),
	.MemWr(MemWr),
	.MemOp(MemOp)
	);
	
ALU			RV32I_ALU( 
    .Rs1(Rs1),
	.Rs2(Rs2),
	.Imm(Imm),	
	.PC(PC),
	.ALUAsrc(ALUAsrc),
	.ALUBsrc(ALUBsrc),
    .ALUctr(ALUctr),    
    .Result(Result),    
    .Zero(Zero),      
    .Less(Less)       
	);
	
DataMem		RV32I_DataMem(
	.Addr	(Result),
	.MemOp	(MemOp),
	.DataIn	(Rs2),
	.WrEn	(MemWr),
	.RdClk	(Clk),
	.WrClk	(Clk),
	.DataOut(DataOut)
	);
	
BranchCond	RV32I_BranchCond(
	.Branch(Branch),
	.Less(Less),
	.Zero(Zero),
	.PCAsrc(PCAsrc),
	.PCBsrc(PCBsrc)
	);
	
endmodule