`timescale 1ns / 1ps

module Processor_TB;
parameter CLK_PERIOD = 10;
reg [4:0] mode;
reg clk,rstn, pause;
wire CB;
wire [7:0] Output;
Processor dut (
    .clk(clk),
    .rstn(rstn),
    .pause(pause),
    .mode(mode),
    .CB(CB),
    .Output(Output)
);

always #((CLK_PERIOD/2)) clk = ~clk;

initial begin
    clk = 0;
    rstn = 0;
    pause = 0;
    mode = 5'b0;
    #50 rstn = 1;mode = 5'b11111;
    #10 pause = 1;mode = 5'b11111;
    #50 pause = 0;mode = 5'b11111;
    #250 $finish;
end

endmodule