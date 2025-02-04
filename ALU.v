module ALU( 
    input	wire		[31:0]  Rs1,
	input	wire		[31:0]  Rs2,
	input	wire		[31:0]  Imm,	
	input	wire		[31:0]  PC,    
	input	wire				ALUAsrc,
	input	wire		[1:0]	ALUBsrc,
    input	wire     	[3:0]   ALUctr,    
    output	reg  		[31:0]  Result,    
    output	reg          		Zero,      
    output	reg          		Less       
	);
	
reg		[31:0]		A,B;

always @(*) begin
    case (ALUctr)
        4'b0000: Result <= A + B;                   // 加法
        4'b1000: Result <= A - B;                   // 减法
        4'b0001, 4'b1001: Result <= A << B[4:0];    // 左移 (逻辑)
        4'b0010: begin                             // 有符号比较
            Less <= ($signed(A) < $signed(B)) ? 1'b1 : 1'b0;
            Result <= $signed(A) - $signed(B);
        end
        4'b1010: begin                             // 无符号比较
            Less <= (A < B) ? 1'b1 : 1'b0;
            Result <= A - B;
        end
        4'b0011, 4'b1011: Result <= B;             // 输出 B
        4'b0100: Result <= A ^ B;                  // 异或
        4'b0101: Result <= A >> B[4:0];            // 逻辑右移
        4'b1101: Result <= $signed(A) >>> B[4:0];  // 算术右移
        4'b0110: Result <= A | B;                  // 或操作
        4'b0111: Result <= A & B;                  // 与操作
        default: Result <= 32'b0;                  // 默认值
    endcase
end

always @(*) begin
	Zero <= (Result == 32'b0) ? 1'b1 : 1'b0;
end

always@(*)begin
	A <= (ALUAsrc) ? PC : Rs1;
	B <= (ALUBsrc[1]) ? 3'd4 : (ALUBsrc[0]) ? Imm : Rs2;
end

endmodule
