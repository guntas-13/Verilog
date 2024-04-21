`timescale 1ns / 1ps

module Processor_TB;
parameter CLK_PERIOD = 10;

reg clk;
reg rstn;
reg pause;

wire [7:0] ACC;
wire [7:0] EXT;
wire CB;

Processor dut (
    .clk(clk),
    .rstn(rstn),
    .pause(pause),
    .ACC(ACC),
    .EXT(EXT),
    .CB(CB)
);

always #((CLK_PERIOD/2)) clk = ~clk;

initial begin
    $monitor($time, " ACC = %b, EXT = %b, CB = %b", ACC, EXT, CB);
    clk = 0;
    rstn = 0;
    pause = 0;
    #50 rstn = 1;
    // #100 pause = 1;
    // #50 pause = 0;
    #200 $finish;
end

endmodule
