`timescale 1ns / 1ps

module Processor(
    clk, rstn, pause
    ACC,
    EXT,
    CB
);

input clk, rstn, pause;
reg [7:0] PROGRAM [15:0];
reg [7:0] RegFile [15:0];
output reg [7:0] ACC;
output reg [7:0] EXT;
output reg CB;
reg [8:0] SUMDIFF;
reg [15:0] MULTDIV;

reg [7:0] IR;
reg [3:0] PC;


/*

1. PROGRAM MEMORY is a 16x8 array to represent
at max 16 instructions of 8 bits each

2. The Program Counter PC is a 4 bit register to store the
address of the current instruction being executed

3. The Instruction Register IR is an 8 bit register to store
the current instruction being executed

4. The Register File is a 16x8 array to store the values of
16 registers of 8 bits each

5. At each clock cycle, the instruction pointed by the PC is
fetched from the PROGRAM MEMORY and stored in IR and exexuted and 
the PC is incremented by 1

6. All ALU operations are performed on the ACC register

7. RSTN is the reset signal. When RSTN is low, the processor is reset

8. PAUSE is a control signal to pause the processor

9. The instructions are of the format:
    1.  0000 0000 : NOP

    2.  0001 xxxx : ADD Ri
    3.  0010 xxxx : SUB Ri
    4.  0011 xxxx : MUL Ri
    5.  0100 xxxx : DIV Ri

    6.  0000 0001 : LSL ACC (Logical Shift Left the contents of ACC. Does not update CB)
    7.  0000 0010 : LSR ACC (Logical Shift Right the contents of ACC. Does not update CB)
    8.  0000 0011 : CIR ACC (Circular Shift Right the contents of ACC. Does not update CB)
    9.  0000 0100 : CIL ACC (Circular Shift Left the contents of ACC. Does not update CB)
    10. 0000 0101 : ASR ACC (Arithmetic Shift Right the contents of ACC. Does not update CB)

    11. 0101 xxxx : AND Ri
    12. 0110 xxxx : XOR Ri
    13. 0111 xxxx : CMP Ri (Compare ACC with Ri. If ACC >= Ri, CB = 0, else CB = 1)

    14. 0000 0110 : INC ACC (Increment ACC by 1. Updates CB if overflow)
    15. 0000 0111 : DEC ACC (Decrement ACC by 1. Updates CB if underflow)

    16. 1000 xxxx : BR <4-bit address> (PC is updated and the program branches to 4-bit address if CB = 1)
    17. 1001 xxxx : MOV Ri (Move the contents of Ri to ACC)
    18. 1010 xxxx : MOV ACC Ri (Move the contents of ACC to Ri)
    19. 1011 xxxx : RET <4-bit address> (PC is updated and program returns to the called program)

    20. 1111 1111 : HLT (Halt the program)
*/

always @(posedge clk or negedge rstn) begin
    if(!rstn)begin

        RegFile[0] <= 8'd1;
        RegFile[1] <= 8'd2;
        RegFile[2] <= 8'd3;
        RegFile[3] <= 8'd4;
        RegFile[4] <= 8'd5;
        RegFile[5] <= 8'd6;
        RegFile[6] <= 8'd7;
        RegFile[7] <= 8'd8;
        RegFile[8] <= 8'd9;
        RegFile[9] <= 8'd10;
        RegFile[10] <= 8'd11;
        RegFile[11] <= 8'd12;
        RegFile[12] <= 8'd13;
        RegFile[13] <= 8'd14;
        RegFile[14] <= 8'd15;
        RegFile[15] <= 8'd16;

        /*

            THE PROGRAM
            1. MOV ACC R1   IR <- 1001 0001  (Load R1 in ACC)             
            2. XOR R1       IR <- 0110 0001  (Clear ACC)                  
            3. ADD R5       IR <- 0001 0101  (ACC + R5)                   
            4. ADD R6       IR <- 0001 0110  (ACC + R6 (which is R5 + R6))
            5. MOV R7 ACC   IR <- 1010 0111  (Store ACC in R7)            
            6. HLT          IR <- 1111 1111                               

        */

        /*
            SIMULATION OF THE PROGRAM
            1. MOV ACC R1   ACC <- 2
            2. XOR R1       ACC <- 0
            3. ADD R5       ACC <- 5
            4. ADD R6       ACC <- 11
            5. MOV R7 ACC   R7 <- 11
            6. HLT
        */

        PROGRAM[0] <= 8'b10010001;
        PROGRAM[1] <= 8'b01100001;
        PROGRAM[2] <= 8'b00010101;
        PROGRAM[3] <= 8'b00010110;
        PROGRAM[4] <= 8'b10100111;
        PROGRAM[5] <= 8'b11111111;

        PC <= 4'b0;
        IR <= 8'b0;
        ACC <= 8'b0;
        EXT <= 8'b0;
        CB <= 1'b0;
        SUMDIFF <= 9'b0;
        MULTDIV <= 16'b0;
    end

    else begin
        if (!pause) begin
            IR <= PROGRAM[PC];
            PC <= PC + 1;
        end

        else begin
            IR <= IR;
            PC <= PC;
        end
    end

end

always @(IR) begin
    case(IR[7:4])
        4'b0000:begin
            if (IR[3:0] == 4'b0000)begin
                //NOP
            end
            else if (IR[3:0] == 4'b0001) begin
                // LSL ACC
                ACC <= ACC << 1;
            end
            else if (IR[3:0] == 4'b0010) begin
                // LSR ACC
                ACC <= ACC >> 1;
            end
            else if (IR[3:0] == 4'b0011) begin
                // CIR ACC
                ACC <= {ACC[0], ACC[7:1]};
            end
            else if (IR[3:0] == 4'b0100) begin
                // CIL ACC
                ACC <= {ACC[6:0], ACC[7]};
            end
            else if (IR[3:0] == 4'b0101) begin
                // ASR ACC
                ACC <= {ACC[7], ACC[7:1]};
            end
            else if (IR[3:0] == 4'b0110) begin
                // INC ACC
                SUMDIFF <= ACC + 1;
                CB <= SUMDIFF[8];
                ACC <= SUMDIFF[7:0];
            end
            else if (IR[3:0] == 4'b0111) begin
                // DEC ACC
                SUMDIFF <= ACC - 1;
                CB <= SUMDIFF[8];
                ACC <= SUMDIFF[7:0];
            end
        end

        4'b0001:begin
            //ADD Ri
            SUMDIFF <= ACC + RegFile[IR[3:0]];
            CB <= SUMDIFF[8];
            ACC <= SUMDIFF[7:0];
        end
        4'b0010:begin
            //SUB Ri
            SUMDIFF <= ACC - RegFile[IR[3:0]];
            CB <= SUMDIFF[8];
            ACC <= SUMDIFF[7:0];
        end
        4'b0011:begin
            //MUL Ri
            MULTDIV <= ACC * RegFile[IR[3:0]];
            ACC <= MULTDIV[7:0];
            EXT <= MULTDIV[15:8];
        end
        4'b0100:begin
            //DIV Ri
            // Need a synthesizable way to implement division
        end
        4'b0101:begin
            //AND Ri
            ACC <= ACC & RegFile[IR[3:0]];
        end
        4'b0110:begin
            //XOR Ri
            ACC <= ACC ^ RegFile[IR[3:0]];
        end
        4'b0111:begin
            //CMP Ri
            SUMDIFF <= ACC - RegFile[IR[3:0]];
            CB <= SUMDIFF[8];
        end
        4'b1000:begin
            //BR <4-bit address>
            if(CB == 1)begin
                PC <= IR[3:0];
            end
        end
        4'b1001:begin
            //MOV Ri
            ACC <= RegFile[IR[3:0]];
        end
        4'b1010:begin
            //MOV ACC Ri
            RegFile[IR[3:0]] <= ACC;
        end
        4'b1011:begin
            //RET <4-bit address>
            PC <= IR[3:0];
        end
        4'b1111:begin
            //HLT
            $finish;
        end
    endcase
end

endmodule