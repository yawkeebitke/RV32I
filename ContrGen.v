module ContrGen(
	input	wire	[31:0]	Instr,
	output	reg		[2:0]	ExtOp,
	output	reg				RegWr,
	output	reg				ALUAsrc,
	output	reg		[1:0]	ALUBsrc,
	output	reg		[3:0]	ALUctr,
	output	reg		[2:0]	Branch,
	output	reg				MemtoReg,
	output	reg				MemWr,
	output	reg		[2:0]	MemOp
	);
	
wire	[7:0]	op;
wire	[4:0]	rs1;
wire	[4:0]	rs2;
wire	[4:0]	rd;
wire	[2:0]	func3;
wire	[6:0]	func7;
	
assign  op  = Instr[6:0];
assign  rs1 = Instr[19:15];
assign  rs2 = Instr[24:20];
assign  rd  = Instr[11:7];
assign  func3  = Instr[14:12];
assign  func7  = Instr[31:25];
	
always@(*)begin
	case(op[6:2])
		5'b01101:begin//copy imm
			ExtOp <= 3'b001;
			RegWr <= 1'b1;
			Branch <= 3'b000;
			MemtoReg <= 1'b0;
			MemWr <= 1'b0;
			MemOp <= 3'b0;
			ALUAsrc <= 1'b0;
			ALUBsrc <= 2'b01;
			ALUctr <= 4'b0011;
		end
		5'b00101:begin//imm+PC
			ExtOp <= 3'b001;
            RegWr <= 1'b1;
            Branch <= 3'b000;
            MemtoReg <= 1'b0;
            MemWr <= 1'b0;
            MemOp <= 3'b0;
            ALUAsrc <= 1'b1;
            ALUBsrc <= 2'b01;
		    ALUctr <= 4'b0000;
		end
		5'b00100:begin
			case(func3)
				3'b000:begin//rs1+imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b010:begin//slt rs1,imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0010;
				end
				3'b011:begin//cltu rs1,imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b1010;
				end				
				3'b100:begin//rs1 ^ imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0100;
				end
				3'b110:begin//rs1 | imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0110;
				end
				3'b111:begin//rs1 & imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0111;
				end
				3'b001:if(!func7[5])begin//rs1 << imm[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0001;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b101:if(!func7[5])begin//rs1 >> imm[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0101;
				end
				else begin//rs1 >>> imm[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b1101;
				end
			endcase
		end
		5'b01100:begin
			case(func3)
				3'b000:if(!func7[5])begin//add rs1 + rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				else begin//sub rs1 - rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b1000;
				end
				3'b001:if(!func7[5])begin//sll rs1 << rs2[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0001;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b010:if(!func7[5])begin//slt rs1,rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0010;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b011:if(!func7[5])begin//sltu rs1,rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b1010;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b100:if(!func7[5])begin//xor rs1 ^ rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0100;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b101:if(!func7[5])begin//srl rs1 >> rs2[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0101;
				end
				else begin//sra rs1 >>> rs2[4:0]
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b1101;
				end
				3'b110:if(!func7[5])begin//or rs1 | rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0110;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
				3'b111:if(!func7[5])begin//and rs1 & rs2
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0111;
				end
				else begin
					ExtOp <= 3'b000;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0000;
				end
			endcase
		end
		5'b11011:begin//jal PC + 4
			ExtOp <= 3'b100;
			RegWr <= 1'b1;
			Branch <= 3'b001;
			MemtoReg <= 1'b0;
			MemWr <= 1'b0;
			MemOp <= 3'b0;
			ALUAsrc <= 1'b1;
			ALUBsrc <= 2'b10;
			ALUctr <= 4'b0000;
		end
		5'b11001:if(func3 == 3'b000)begin//jalr PC + 4
			ExtOp <= 3'b000;
			RegWr <= 1'b1;
			Branch <= 3'b010;
			MemtoReg <= 1'b0;
			MemWr <= 1'b0;
			MemOp <= 3'b0;
			ALUAsrc <= 1'b1;
			ALUBsrc <= 2'b10;
			ALUctr <= 4'b0000;
		end
		else begin
			ExtOp <= 3'b000;
			RegWr <= 1'b0;
			Branch <= 3'b000;
			MemtoReg <= 1'b0;
			MemWr <= 1'b0;
			MemOp <= 3'b0;
			ALUAsrc <= 1'b0;
			ALUBsrc <= 2'b00;
			ALUctr <= 4'b0000;
		end
		5'b11000:begin
			case(func3)
				3'b000:begin//beq set Zero
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b100;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0010;
				end
				3'b001:begin//bne set Zero
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b101;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0010;
				end
				3'b100:begin//blt set signed Less
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b110;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0010;
				end
				3'b101:begin//bge set signed Less
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b111;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b0010;
				end
				3'b110:begin//bltu set unsigned Less
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b110;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b1010;
				end
				3'b111:begin//bgeu set unsigned Less
					ExtOp <= 3'b011;
					RegWr <= 1'b0;
					Branch <= 3'b111;
					MemtoReg <= 1'b0;
					MemWr <= 1'b0;
					MemOp <= 3'b0;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b00;
					ALUctr <= 4'b1010;
				end
			endcase
		end
		5'd00000:begin
			case(func3)
				3'b000:begin//Ib rs1 + imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b1;
					MemWr <= 1'b0;
					MemOp <= 3'b000;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b001:begin//Ih rs1 + imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b1;
					MemWr <= 1'b0;
					MemOp <= 3'b001;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b010:begin//Iw rs1 + imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b1;
					MemWr <= 1'b0;
					MemOp <= 3'b010;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b100:begin//Ibu rs1 + imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b1;
					MemWr <= 1'b0;
					MemOp <= 3'b100;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b101:begin//Ihu rs1 + imm
					ExtOp <= 3'b000;
					RegWr <= 1'b1;
					Branch <= 3'b000;
					MemtoReg <= 1'b1;
					MemWr <= 1'b0;
					MemOp <= 3'b101;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
			endcase
		end
		5'b01000:begin
			case(func3)
				3'b000:begin//sb rs1 + imm
					ExtOp <= 3'b010;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b1;
					MemOp <= 3'b000;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b001:begin//sh rs1 + imm
					ExtOp <= 3'b010;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b1;
					MemOp <= 3'b001;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
				3'b010:begin//sw rs1 + imm
					ExtOp <= 3'b010;
					RegWr <= 1'b0;
					Branch <= 3'b000;
					MemtoReg <= 1'b0;
					MemWr <= 1'b1;
					MemOp <= 3'b010;
					ALUAsrc <= 1'b0;
					ALUBsrc <= 2'b01;
					ALUctr <= 4'b0000;
				end
			endcase
		end
	default:begin
		ExtOp <= 3'b000;
	    RegWr <= 1'b0;
	    Branch <= 3'b000;
	    MemtoReg <= 1'b0;
	    MemWr <= 1'b0;
	    MemOp <= 3'b0;
	    ALUAsrc <= 1'b0;
	    ALUBsrc <= 2'b00;
		ALUctr <= 4'b0000;
	end
	endcase
end	

endmodule