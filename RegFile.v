module RegFile(
	input 	wire	[4:0]	Ra,
	input 	wire	[4:0]	Rb,
	input 	wire	[4:0]	Rw,
	input 	wire	[31:0]	Result,
	input 	wire	[31:0]	DataOut,
	input 	wire			MemtoReg,
	input 	wire			RegWr,
	input 	wire			WrClk,
	input	wire			Rst,
	output 	wire	[31:0]	BusA,
	output 	wire	[31:0]	BusB,
	output  reg             Testsign_01
	);
	
integer i; 
					
reg		[31:0]	Regs[0:31];	

	

always@(negedge WrClk)
	if(!Rst)begin
		for (i = 0; i < 32; i = i + 1)  
            Regs[i] <= 32'b0;
        Testsign_01 <= 1'b0;    
    end  
	else if(RegWr && Rw != 5'b00000)begin
		Regs[Rw] = (MemtoReg) ? DataOut : Result;
		Testsign_01 = 1'b1;
	end
	else begin
		for (i = 0; i < 32; i = i + 1)  
            Regs[i] <= Regs[i];
        Testsign_01 <= 1'b0;
    end

assign BusA = Regs[Ra];
assign BusB = Regs[Rb];
					
endmodule