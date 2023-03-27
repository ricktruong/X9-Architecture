# Parses machine code for bad register input and reports lines with errors

import sys
import os
import string
import argparse
import re

R_set =set(["ADD", "SUB", "LB", "SB","BNE", "NOR", "XOR", "AND", "OR", "SLL", "SLR", "EQ", "LT", "RXOR"])
Ri_set = set(["ADDI"])
M_set = set(["MOVR"])
Mi_set = set(["MOVI"])
B_set = set (["BT"])

B_map = { "LOAD_MESSAGE":"0000"}

op_map ={ 
        "ADD" : "00000",
        "SUB" : "00001", 
        "LB" : "00011",
        "SB"  : "00100",
        "BEQ" : "00101",
        "BT" : "00101",
        "BNE" : "00110",
        "NOR" : "00111",
        "XOR" : "01000",
        "AND" : "01001",
        "OR"  : "01010", 
        "SLL" : "01011",
        "SLR" : "01100", 
        "EQ"  : "01101", 
        "LT"  : "01110",
        "RXOR": "01111",
        "ADDI": "00010",
        "MOVR": "10",
        ##"BEQ": "101",
        "MOVI": "11",
       
}


reg_map_R ={
    "0": "00",
    "1": "01",
    "2": "10",
    "3": "11",
    "4": "00",
    "5": "01",
    "6": "10",
    "7": "11"
}


def parse_R(line, insttype, count):

    #Regex for removing spaces
    pattern=r"\s+"
    operands = re.sub(pattern, "", line)
    aluop = op_map[insttype]
    operands = operands.split(",$")

    checkOperand1 =""
    checkOperand2 =""


    if (int(operands[0]) <= 3 and int(operands[0]) >=0):
        checkOperand1 = "    // Correct op1:" + operands[0]
    else:
        checkOperand1 = "    // ------------Incorrect op1:" + operands[0]

    if (int(operands[1]) < 8 and int(operands[1]) >=4):
        checkOperand2 = "    //Correct op2:" + operands[1]
    else:
        checkOperand2 = "    // -------------Incorrect op2:" + operands[1]

    linecount = " at line number" + str(count)
    
    operand1 = reg_map_R[operands[0]]
    operand2 = reg_map_R[operands[1]]
    finalinstruction = insttype + operands[0]+","+operands[1]+ " ; "+ aluop+ "_" +operand1+"_"+operand2+checkOperand1+checkOperand2+linecount+"\n"
    #print(operands)
    return finalinstruction


""" ASSEMBLER MAIN FUNCTIONALITY """
def main(input, output):
    count = 1
    # str = "prog_1.s"
    
    try:
        inputfile = open(input, "r")
        outputfile = open(output, "w")
        content = inputfile.readlines()
        for line in content:
            if line.isspace():
                continue
            if ":" in line:
                continue

            if ";" in line:
                uncommentedline= line.split(";")[0]
                if uncommentedline.isspace():
                    continue

            else:
                uncommentedline = line.strip()

            
            cleanline = uncommentedline.replace("@", "$", 1)
            operands = cleanline.split("$", 1)[1].strip()
            insttype = cleanline.split("$", 1)[0].strip()
            insttype = insttype.upper()
            
            if insttype in R_set:
               finalinstruction = parse_R(operands, insttype, count)
               outputfile.write(finalinstruction)

            count = count + 1
            
    finally:
        inputfile.close()
        outputfile.close()


if __name__ == "__main__":
    
    # Command line arguments are formatted incorrectly
    if (len(sys.argv) != 3):
        print("Invalid number of arguments.")
        print("usage: assembler.py INPUT_FILE OUTPUT_FILE")
        exit(0)
    
    # Input and output command line argument received
    else:
        input, output = sys.argv[1], sys.argv[2]
        main(input, output)
