import sys
from RursusToken import RursusToken



def removeComments(pRightSides):
    resultRightSides = ""
    commenting = False
    for i in range(0,len(pRightSides)):
        if pRightSides[i]=="/" and pRightSides[i+1]=="*":
            commenting = True
        elif pRightSides[i-1]=="*" and pRightSides[i]=="/":
            #i+=2
            commenting = False
        else:
            if not commenting:
                resultRightSides+=pRightSides[i]
    return resultRightSides


def getRightSidesTable(pFileName):
    with open(pFileName,'r') as file:
        RightSides = file.read()
    RightSides = removeComments(RightSides)
    RightSides = RightSides.split("{")[3:]

    for i in range(0,len(RightSides)-1):
        RightSides[i] = RightSides[i].split("}")[0]

    
    RightSides = RightSides[:len(RightSides)-1]

    for i in range(0,len(RightSides)):
        RightSides[i] = RightSides[i].split(",")

    return RightSides
