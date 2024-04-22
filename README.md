# **ES204 Digital Systems Verilog**

### **To Compile the Verilog Code using ```icarus-iverilog``` Compiler**
```bash
iverilog -o outputBinaryFile verilogModuleFile(s).v TestBenchFile.v
```

### **To Execute the Binary File**
```bash
vvp outputBinaryFile
```

## **Final Processor**
![](https://github.com/guntas-13/Verilog/blob/main/FinalProcessor/FPGA.png)
![](https://github.com/guntas-13/Verilog/blob/main/FinalProcessor/Result.png)


```
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
```
