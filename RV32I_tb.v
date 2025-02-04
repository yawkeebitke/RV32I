module RV32I_tb;

reg				clk,rst;

wire	[31:0]	instr,imm,result,PC;
wire    [31:0]  x5,x6,x7,x8,x9;
assign	x5 = RV32I_tb.RV32I_tb.RV32I_RegFile.Regs[5];
assign	x6 = RV32I_tb.RV32I_tb.RV32I_RegFile.Regs[6];
assign	x7 = RV32I_tb.RV32I_tb.RV32I_RegFile.Regs[7];
assign	x8 = RV32I_tb.RV32I_tb.RV32I_RegFile.Regs[8];
assign	x9 = RV32I_tb.RV32I_tb.RV32I_RegFile.Regs[9];

RV32I	RV32I_tb(
				.Clk(clk),
				.Rst(rst),
				.Instr(instr),
				.Imm(imm),
				.Result(result),
				.PC(PC)
				);
				
always#10		clk <= ~clk;

initial begin
	$monitor("At time %t: PC = %d, x5 = %d, x6 = %d, x7 = %d, x8 = %d, x9 = %d", $time, PC, x5, x6, x7, x8, x9);
	rst <= 1'b0;clk <= 1'b0;
	#35	rst <= 1'b1;
end

endmodule