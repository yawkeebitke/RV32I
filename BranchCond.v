module BranchCond(
	input	wire	[2:0]	Branch,
	input	wire			Less,
	input	wire			Zero,
	output	reg				PCAsrc,
	output	reg				PCBsrc
	);
	
always@(*)begin
	case(Branch)
		3'b000:begin
			PCAsrc <= 1'b0;
			PCBsrc <= 1'b0;
		end
		3'b001:begin
			PCAsrc <= 1'b1;
			PCBsrc <= 1'b0;
		end
		3'b010:begin
			PCAsrc <= 1'b1;
			PCBsrc <= 1'b1;
		end
		3'b100:begin
			PCAsrc <= (Zero) ? 1'b1 : 1'b0;
			PCBsrc <= 1'b0;
		end
		3'b101:begin
			PCAsrc <= (Zero) ? 1'b0 : 1'b1;
			PCBsrc <= 1'b0;
		end
		3'b110:begin
			PCAsrc <= (Less) ? 1'b1 : 1'b0;
			PCBsrc <= 1'b0;
		end
		3'b111:begin
			PCAsrc <= (Less) ? 1'b0 : 1'b1;
			PCBsrc <= 1'b0;
		end
		default:begin
			PCAsrc <= 1'b0;
			PCBsrc <= 1'b0;
		end
	endcase
end
	
endmodule