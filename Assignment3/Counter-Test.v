module testbench;

reg En, rstn, clk, SEL1, SEL2;
reg [3:0] preset;
wire [3:0] Q;

counter count(.En(En), .rstn(rstn), .clk(clk), .preset(preset), .SEL1(SEL1), .SEL2(SEL2), .Q(Q));


always #5 clk = ~clk;

initial begin
    /*
    MODE ->
        00 -> DOWN-BIN
        01 -> DOWN-BCD
        10 -> UP-BIN
        11 -> UP-BCD
    */

    rstn <= 0; SEL1 = 1; SEL2 = 0;  // MODE = 10
    preset <= 4'b1111;
    clk <= 0;
    En = 1;
    $monitor($time, " MODE = %b%b, Q4Q3Q2Q1 = %b%b%b%b, Q = %d", SEL1, SEL2, Q[3], Q[2], Q[1], Q[0], Q);
    #5 rstn <= 1;
    #398 SEL1 = 0;              // MODE = 00
    #398 SEL1 = 1; SEL2 = 1;    // MODE = 11
    #398 SEL1 = 0;              // MODE = 01
    #398 $finish;
end


endmodule