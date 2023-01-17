import sys
from RursusToken import RursusToken



def removeComments(pParsingTable):
    resultParsingTable = ""
    commenting = False
    for i in range(0,len(pParsingTable)):
        if pParsingTable[i]=="/" and pParsingTable[i+1]=="*":
            commenting = True
        elif pParsingTable[i-1]=="*" and pParsingTable[i]=="/":
            #i+=2
            commenting = False
        else:
            if not commenting:
                resultParsingTable+=pParsingTable[i]
    return resultParsingTable


def getParsingTable(pFileName):
    with open(pFileName,'r') as file:
        parsingTable = file.read()
    parsingTable = removeComments(parsingTable)
    parsingTable = parsingTable.split("{")[3:]

    for i in range(0,len(parsingTable)-1):
        parsingTable[i] = parsingTable[i].split("}")[0]

    
    parsingTable = parsingTable[:len(parsingTable)-1]

    for i in range(0,len(parsingTable)):
        parsingTable[i] = parsingTable[i].split(",")

    return parsingTable
