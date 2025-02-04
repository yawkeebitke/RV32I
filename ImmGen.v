module ImmGen(
	input	wire	[31:0]	Instr,
	input	wire	[2:0]	ExtOp,	
	output	wire	[31:0]	Imm
	);
	
wire	[31:0]		immI,immU,immS,immB,immJ;

assign immI = {{20{Instr[31]}}, Instr[31:20]};
assign immU = {Instr[31:12], 12'b0};
assign immS = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
assign immB = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
assign immJ = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};

assign Imm = (ExtOp[2])?immJ:((ExtOp[1])?((ExtOp[0])?immB:immS):((ExtOp[0])?immU:immI));
	
endmodule