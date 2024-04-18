module multipleR(A, SEL, OUT);

input [4:0] A;
input [3:0] SEL; 
output reg [31:0] OUT;

reg [5:0] N;
reg [31:0] temp;

always @(*) begin
    temp = 0;
    for (N = 0; N < A ; N = N + SEL) begin
        temp[N] = 1;
    end

    OUT = temp;
end

endmodule