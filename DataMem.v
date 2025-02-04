module DataMem(
	input	wire	[31:0]		Addr	,
	input	wire	[2:0]		MemOp	,
	input	wire	[31:0]		DataIn	,
	input	wire				WrEn	,
	input	wire				RdClk	,
	input	wire				WrClk	,
	output	reg		[31:0]		DataOut
	);
	
integer i;
	
reg		[31:0]		datamem		[0:255];

always@(negedge RdClk)begin
	case(MemOp)
		3'b010:DataOut <= datamem[Addr[7:0]];
		3'b001:DataOut <= {{16{datamem[Addr[7:0]][16]}},datamem[Addr[7:0]][15:0]};
		3'b000:DataOut <= {{24{datamem[Addr[7:0]][8]}},datamem[Addr[7:0]][7:0]};
		3'b101:DataOut <= {{16{1'b0}},datamem[Addr[7:0]][15:0]};
		3'b100:DataOut <= {{24{1'b0}},datamem[Addr[7:0]][7:0]};
		default:DataOut <= 32'd0;
	endcase
end

always@(negedge WrClk)begin
	if(WrEn)begin
		datamem[Addr[7:0]] <= DataIn;
	end
	else begin
		for(i = 0;i < 256;i = i + 1)begin
			datamem[i] <= datamem[i];
		end
	end
end
	
endmodule