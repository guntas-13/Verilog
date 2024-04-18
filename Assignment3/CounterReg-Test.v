module testbench;


reg En, rstn, clk, SEL1, SEL2;
reg [1:0] SEL3;
reg [3:0] preset;
wire [3:0] Q;
wire [3:0] Q1;

counter count(.En(En), .rstn(rstn), .clk(clk), .preset(preset), .SEL1(SEL1), .SEL2(SEL2), .Q(Q));
shiftreg sftreg(.En(~En), .clk(clk), .preset(Q), .SEL3(SEL3), .Q(Q1));


always #5 clk = ~clk;

initial begin
    /*
    MODE ->
        En = 1 -> Counter ON
        En = 0 -> ShiftReg ON

        000 -> DOWN-BIN-ParallelShift
        010 -> DOWN-BCD-ParallelShift
        100 -> UP-BIN-ParallelShift
        110 -> UP-BCD-ParallelShift

        001 -> DOWN-BIN-RightShift
        011 -> DOWN-BCD-RightShift
        101 -> UP-BIN-RightShift
        111 -> UP-BCD-RightShift

        002 -> DOWN-BIN-LeftShift
        012 -> DOWN-BCD-LeftShift
        102 -> UP-BIN-LeftShift
        112 -> UP-BCD-LeftShift
    */

    rstn <= 0; SEL1 = 1; SEL2 = 0; SEL3 = 2'b00;  // MODE = 100
    preset <= 4'b1111;
    clk <= 0;
    En = 1;
    $monitor($time, " En = %b, MODE = %b%b%d, Q4Q3Q2Q1 = %b%b%b%b, Q = %d, ShiftRegOut = %b%b%b%b", En, SEL1, SEL2, SEL3, Q[3], Q[2], Q[1], Q[0], Q, Q1[3], Q1[2], Q1[1], Q1[0]);
    #5 rstn <= 1;
    #398 SEL1 = 0;              // MODE = 000
    #398 SEL1 = 1; SEL2 = 1;    // MODE = 110
    #398 SEL1 = 0;              // MODE = 010
    #409 En = 0;                // Shift Reg statrs
    #10 SEL3 = 2'b01;               // Right Shift
    #40 SEL3 = 2'b00; SEL3 = 2'b10; // Left Shift
    #40 $finish;
end

endmodule