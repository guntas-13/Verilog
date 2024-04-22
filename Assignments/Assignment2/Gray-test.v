module testbench;

reg [8:0] binary;
wire [8:0] gray;

GrayConverter conv(.binary(binary), .gray(gray));

initial begin
    $monitor($time, " BIN = %b, GRAY = %b", binary, gray);
    binary = 9'b010110101;
    #5 binary = 9'b100101101;
    #5 $finish;
end

endmodule