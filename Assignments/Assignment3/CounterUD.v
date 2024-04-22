module counter(
    input En, 
    input rstn, clk,
    input [3:0] preset,
    input SEL1, SEL2,
    output [3:0] Q
    );

// rstn = 0 -> the Flip Flop resets or clears
// [3:0] preset -> 0000 sets all T flip flops to Q1, Q2, Q3, Q4 = 1, 1, 1, 1


// SEL1 -> Decides for UP/DOWN
// f1 = UP.(SEL1) + DOWN.(~SEL1)
// f1 = UP when SEL1 = 1
// f1 = DOWN when SEL1 = 0

// SEL2 -> Decides for BCD/BIN where (BCD -> MOD 10 counter) and (BIN -> MOD 16 counter)
// f2 = BCD.(SEL2) + BIN.(~SEL2)
// f2 = BCD when SEL2 = 1
// f2 = BIN when SEL2 = 0


/*
LOGIC -> for SEL1 (UP/DOWN)
    t1 = En
    t2 = q1.SEL1 + (~q1).(~SEL1)
    t3 = q2.q1.SEL1 + (~q2).(~q1).(~SEL1)
    t4 = q3.q2.q1.SEL1 + (~q3).(~q2).(~q1).(~SEL1)
*/

nand (new_rstn, Q[1], Q[3], SEL2, SEL1);

// it will check for resetting the flip flops to 0000 when they are at 
// the state 1010 (Asynchronous RESET) and the UP-BCD is chosen (SEL1 = 1 and SEL2 = 1)
// 1000 -> 1001 -> 1010 (Normally)
// 1000 -> 1001 -> 0000 (Wanted)


nand (new_preset, Q[0], Q[1], Q[2], Q[3], ~SEL1, SEL2);
// we wish to PRESET Q1 and Q4 and RESET Q2 and Q3 giving Q4Q3Q2Q1 = 1001
// when we reach Q4Q3Q2Q1 = 1111 (Asynchronous PRESET) and the DOWN-BCD is chosen (SEL1 = 0 and SEL2 = 1)
// 0001 -> 0000 -> 1111 (Normally)
// 0001 -> 0000 -> 1001 (Wanted)

wire q1, q2, q3, q4;
wire t2, t3, t4;
wire temp1_0, temp1_1;
wire temp2_0, temp2_1;

tff T1(.T(En), .rstn(new_rstn & rstn), .preset(preset[0] & new_preset), .clk(clk), .Q(q1));
xnor (t2, q1, SEL1);

tff T2(.T(t2), .rstn(new_rstn & rstn & new_preset), .preset(preset[1]), .clk(clk), .Q(q2));
and (temp1_0, q2, q1, SEL1);
and (temp1_1, ~q2, ~q1, ~SEL1);
or (t3, temp1_0, temp1_1);

tff T3(.T(t3), .rstn(new_rstn & rstn & new_preset), .preset(preset[2]), .clk(clk), .Q(q3));
and (temp2_0, q3, q2, q1, SEL1);
and (temp2_1, ~q3, ~q2, ~q1, ~SEL1);
or (t4, temp2_0, temp2_1);

tff T4(.T(t4), .rstn(new_rstn & rstn), .preset(preset[3] & new_preset), .clk(clk), .Q(q4));

assign Q = {q4, q3, q2, q1};

endmodule