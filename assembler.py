
import sys
import os
import string
import argparse
import re

R_set =set(["ADD", "SUB", "LB", "SB","BT","BNE", "NOR", "XOR", "AND", "OR", "SLL", "SLR", "EQ", "LT", "RXOR"])
Ri_set = set(["ADDI"])
M_set = set(["MOVR"])
Mi_set = set(["MOVI"])
# B_set = set (["BEQ"])
# B_map ={}
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

reg_map_Ri ={
    "0": "00",
    "1": "01",
    "-2": "10",
    "-1": "11",
}
reg_map_M ={
    "0": "000",
    "1": "001",
    "2": "010",
    "3": "011",
    "4": "100",
    "5": "101",
    "6": "110",
    "7": "111"
}
reg_map_Mi ={
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "-8": "1000",
    "-7": "1001",
    "-6": "1010",
    "-5": "1011",
    "-4": "1100",
    "-3": "1101",
    "-2": "1110",
    "-1": "1111",
}
def parse_R(line, insttype):

    #Regex for removing spaces
    pattern=r"\s+"
    operands = re.sub(pattern, "", line)
    #print ("operand line is " + operands)

    aluop = op_map[insttype]
    operands = operands.split(",$")
    #print("insttype is "+ insttype)
    #print(" Operand 0 is" + operands[0] + "Operand 1 is" + operands[1])
    operand1 = reg_map_R[operands[0]]
    operand2 = reg_map_R[operands[1]]
    finalinstruction = aluop+operand1+operand2+"\n"
    #print(operands)
    return finalinstruction


def parse_Ri(line, insttype):
    
    #Regex for removing spaces
    pattern=r"\s+"
    operands = re.sub(pattern, "", line)
    #print ("operand line is " + operands)

    aluop = op_map[insttype]
    operands = operands.split(",#")
    operand1 = reg_map_R[operands[0]]
    operand2 = reg_map_Ri[operands[1]]
    finalinstruction = aluop+operand1+operand2+"\n"
    #print(operands)
    return finalinstruction


def parse_M(line, insttype):
    #Regex for removing spaces
    pattern=r"\s+"
    operands = re.sub(pattern, "", line)
    #print ("operand line is " + operands)

    aluop = op_map[insttype]
    operands = operands.split(",$")
    operand1 = reg_map_M[operands[0]]
    operand2 = reg_map_M[operands[1]]
    #print(operands)
    finalinstruction = aluop+operand1+operand2+"0"+"\n"
    return finalinstruction


def parse_Mi(line, insttype):
    #Regex for removing spaces
    pattern=r"\s+"
    operands = re.sub(pattern, "", line)

    aluop = op_map[insttype]
    operands = operands.split(",#")
    #print(operands)
    operand1 = reg_map_M[operands[0]]
    operand2 = reg_map_Mi[operands[1]]
    finalinstruction = aluop+operand1+operand2+"\n"
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
            #print("unaltered line is " + line)
            if ";" in line:
                uncommentedline= line.split(";")[0]
                if uncommentedline.isspace():
                    continue
          
            else:
                uncommentedline = line.strip()
            #print("uncommented line is " + uncommentedline )
            
            #print(count )
            #print("uncommented line is "+ uncommentedline)   
            operands = uncommentedline.split("$", 1)[1].strip()
            insttype = uncommentedline.split("$", 1)[0].strip()
            #print("operands are " + operands)
            insttype = insttype.upper()
            #print(insttype)
            
            if insttype in R_set:
               finalinstruction = parse_R(operands, insttype)
               outputfile.write(finalinstruction)

            if insttype in M_set:
                finalinstruction = parse_M(operands, insttype)
                outputfile.write(finalinstruction)
            if insttype in Ri_set:
                finalinstruction = parse_Ri(operands, insttype)
                outputfile.write(finalinstruction)
            if insttype in Mi_set:
                finalinstruction = parse_Mi(operands, insttype)
                outputfile.write(finalinstruction)
            count = count + 1
            # if insttype in B_set:
            #     finalinstruction = parse_B(operands, insttype)
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
