1. Explain which programs/features work
- Program 1 passes all 15 tests on prog1_tb.sv
- Our assembler (assembler.py) works as all code is translated as expected
- All hardware modules work
    - top_level.sv works as intended
    - PC_LUT.sv ensures branching works as intended for tested programs
    - PC.sv works with absolute branching
    - instr_ROM.sv was left unchanged
    - Control.sv properly regulates functionality for all instructions in the datapath
    - reg_file.sv was left unchanged
    - alu.sv supports all logical and arithmetic instructions
    - dat_mem.sv was left unchanged
    - All muxes were implemented logically and correctly

2. Explain which programs/features don't work and what challenges you faced when
implementing your design
- Program 2 and Program 3 do not work. 
- We had some challenges getting questa to display enough statements to be helpful in debugging
- Had some miscommication with referencing solutions on different branches
- Had some misunderstandings about how bits were indexed
- Had issues trying to get our original branching mechanism to work as our program was much larger than anticipated
- 

3. Include the link and passcode to zoom video
