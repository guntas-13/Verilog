module testbench;

reg [1:0] I;
wire [3:0] O;
deco e(.I(I), .O(O));

initial begin
    $monitor($time, " I = %b, O = %b", I, O);
    I = 2'b00;
    #5 I = 2'b01;
    #5 I = 2'b10;
    #5 I = 2'b11;
    #5 $finish;
end

endmodule