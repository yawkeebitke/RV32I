module PC(
	input 	wire 			Clk,
	input	wire			Rst,
	input	wire	[31:0]	Imm,
	input	wire	[31:0]	Rs1,
	input	wire			PCAsrc,
	input	wire			PCBsrc,
	output	reg		[31:0]	PC
	);
	
reg		[31:0]		TimeOne,TimeTwo;
	
always@(negedge Clk or negedge Rst)begin
	if(!Rst)begin
		PC <= 31'd0;
	end
	else begin
		TimeOne = (PCAsrc) ? Imm : 3'd4;
		TimeTwo = (PCBsrc) ? Rs1 : PC;
		PC = TimeOne + TimeTwo;
//	    PC = PC + 3'd4;
	end
end
		
endmodule