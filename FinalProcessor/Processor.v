`timescale 1ns / 1ps

module Tinyprocessor(clk,rstn,mode,carry_borrow,Opcode,regaddr,Acc);
input clk,mode,rstn;
reg hlt;
output reg carry_borrow;
input [3:0] Opcode,regaddr;
reg [15:0] RegFile [7:0];
output reg [7:0] Acc ;
reg [7:0] EXT ;
reg [8:0] Sum_Diff;
reg [15:0] Mult_Div;
reg [7:0] PC ;
integer i,j;

always @(posedge clk or posedge rstn ) begin
 
    if (rstn) begin
        for (i = 0; i < 16; i = i + 1) begin
            RegFile[i] <= 8'b1 << i;
        end
        Acc <= 8'b0;
        EXT <= 8'b0;
        PC[7:4] <= Opcode;
        PC[3:0] <= regaddr ; 
        carry_borrow <= 0;
      
    end
    else begin
        if (Opcode == 4'b0000) begin
            if(regaddr == 4'b0000)begin
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0001)begin
            //Left shift left logical the contents of ACC.
                Acc <= Acc<<(1);
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0010)begin
            //Left shift right logical the contents of ACC.
                Acc <= Acc>>(1);
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0011)begin
            //Circuit right shift ACC contents.
                Acc <= {Acc[0], Acc[7:1]};
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0100)begin
            //Circuit left shift ACC contents.
                Acc <= {Acc[6:0], Acc[7]};
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0101)begin
            //Arithmetic Shift Right ACC contents
                Acc <= {Acc[7], (Acc[6:0]>>(1))};
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0110)begin
            //Increments ACC, updates C/B when overflows
                Sum_Diff <= 8'b0;
                Sum_Diff <= Acc + 1;
                Acc <= Sum_Diff[7:0];
                carry_borrow <= Sum_Diff[8];
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
            else if(regaddr == 4'b0111)begin
            //Decrements ACC, updates C/B when underflows
                Sum_Diff <= 8'b0;
                Sum_Diff <= Acc - 1;
                Acc <= Sum_Diff[7:0];
                carry_borrow <= Sum_Diff[8];
                PC[7:4] = Opcode;
                PC[3:0] = regaddr ; 
            end
        end   
        else if(Opcode == 4'b0001)begin
            //Add ACC with Register contents and store the result in ACC. Updates C/B
            Sum_Diff <= 8'b0;
            Sum_Diff <= Acc + RegFile[regaddr];
            Acc <= Sum_Diff[7:0];
            carry_borrow <= Sum_Diff[8];
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ; 
        end   
        else if(Opcode == 4'b0010)begin
            //Subtract ACC with Register contents and store the result in ACC. Updates C/B
            Sum_Diff <= 8'b0;
            Sum_Diff <= Acc - RegFile[regaddr];
            Acc <= Sum_Diff[7:0];
            carry_borrow <= Sum_Diff[8];
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ; 
        end 
        else if(Opcode == 4'b0011)begin
            //Multiple ACC with Register contents and store the result in ACC. Updates EXT
            Mult_Div <= 15'b0;
            for (i = 0; i < 8; i = i + 1) begin : outer_loop
                for (j = 0; j < 8; j = j + 1) begin : inner_loop
                    Mult_Div <= Mult_Div + ((Acc[i] & RegFile[regaddr][j]) << (i + j));
                end
            end
            Acc <= Mult_Div[7:0];
            EXT <= Mult_Div[15:8];
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b0100)begin
            //Divides ACC with Register contents and store the Quotient in ACC. Updates EXT with remainder.
            Mult_Div <= 15'b0;
            Acc <= Acc/(RegFile[regaddr]);
            Acc <= Acc/(RegFile[regaddr]);
            EXT <= Acc%(RegFile[regaddr]); 
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b0101)begin
            //AND ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated
            Acc <= Acc & RegFile[regaddr];
            PC[7:4] = Opcode;
             PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b0110)begin
            //XRA ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated
            Acc <= Acc ^ RegFile[regaddr];
            PC[7:4] = Opcode;
             PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b0111)begin
            //CMP ACC with Register contents (ACC-Reg)and update C/B. If ACC>=Reg, C/B=0, else C/B=1
            carry_borrow = (
            (~Acc[7] & RegFile[regaddr][7])
            |((Acc[7] ^ RegFile[regaddr][7]) & (~Acc[6] & RegFile[regaddr][6]))
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & (~Acc[5] & RegFile[regaddr][5]))) 
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & ((Acc[5] ^ RegFile[regaddr][5])& (~Acc[4] & RegFile[regaddr][4]))))
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & ((Acc[5] ^ RegFile[regaddr][5])&  ((Acc[4] ^ RegFile[regaddr][4])&(~Acc[3] & RegFile[regaddr][3])))))
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & ((Acc[5] ^ RegFile[regaddr][5])&  ((Acc[4] ^ RegFile[regaddr][4])&((Acc[3] ^ RegFile[regaddr][3])&(~Acc[2] & RegFile[regaddr][2]))))))
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & ((Acc[5] ^ RegFile[regaddr][5])&  ((Acc[4] ^ RegFile[regaddr][4])&((Acc[3] ^ RegFile[regaddr][3])&((Acc[2] ^ RegFile[regaddr][2])&(~Acc[1] & RegFile[regaddr][1])))))))
            ||((Acc[7] ^ RegFile[regaddr][7]) & ((Acc[6] ^ RegFile[regaddr][6]) & ((Acc[5] ^ RegFile[regaddr][5])&  ((Acc[4] ^ RegFile[regaddr][4])&((Acc[3] ^ RegFile[regaddr][3])&((Acc[2] ^ RegFile[regaddr][2])&((Acc[1] ^ RegFile[regaddr][1])&(~Acc[0] & RegFile[regaddr][0])))))))));
             PC[7:4] = Opcode;
             PC[3:0] = regaddr ;        
        end 
        else if(Opcode == 4'b1000)begin
            //PC is updated and the program Branches to 4-bit address if C/B=1
            if(carry_borrow == 1)begin
                PC <= RegFile[regaddr];
            end
            else begin
            end
        end 
        else if(Opcode == 4'b1001)begin
            //Moves the contents of Ri to ACC
            Acc <= RegFile[regaddr];
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b1010)begin
            //Moves the contents of ACC to Ri
            RegFile[regaddr] <= Acc ;
            PC[7:4] = Opcode;
            PC[3:0] = regaddr ;   
        end 
        else if(Opcode == 4'b1011)begin
            //PC is updated, and the program returns to the called program.
            PC <= RegFile[regaddr];  
        end 
        else if (Opcode == 4'b1111)begin
            if(regaddr == 4'b1111)begin
                hlt = 0;
            end
        end
     end
end
assign Opcode = PC[7:4];
assign regaddr = PC[3:0];
endmodule