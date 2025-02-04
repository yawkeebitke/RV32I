module InstrMem(
    input   wire            Rdclk,
	input	wire			Rdrst,
    input   wire    [31:0]  Rdaddr,
    output  reg     [31:0]  Instr
    );
    
reg [31:0] memory [0:255];  

always@(negedge Rdclk or negedge Rdrst) begin  
    if(!Rdrst) begin  
        Instr <= 32'd0;  
    end else begin  
        Instr <= memory[Rdaddr[7:0]];  
    end  
end  

endmodule