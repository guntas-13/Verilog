module decoder(input [3:0] A, output reg [15:0] OUT);

always @(*) begin
    case(A)
        4'd0  : OUT = 16'b0000000000000001;
        4'd1  : OUT = 16'b0000000000000010;
        4'd2  : OUT = 16'b0000000000000100;
        4'd3  : OUT = 16'b0000000000001000;
        4'd4  : OUT = 16'b0000000000010000;
        4'd5  : OUT = 16'b0000000000100000;
        4'd6  : OUT = 16'b0000000001000000;
        4'd7  : OUT = 16'b0000000010000000;
        4'd8  : OUT = 16'b0000000100000000;
        4'd9  : OUT = 16'b0000001000000000;
        4'd10 : OUT = 16'b0000010000000000;
        4'd11 : OUT = 16'b0000100000000000;
        4'd12 : OUT = 16'b0001000000000000;
        4'd13 : OUT = 16'b0010000000000000;
        4'd14 : OUT = 16'b0100000000000000;
        4'd15 : OUT = 16'b1000000000000000;
        default : OUT = 16'b0000000000000000;
    endcase
end
endmodule



module logc(A, OUT);

input [3:0] A;
output OUT;

wire [15:0] decode;
decoder dec(.A(A), .OUT(decode));

assign OUT = decode[0] | decode[2] | decode[3] | decode[4] | decode[7] | decode[8] | decode[10] | decode[11] | decode[15];

endmodule