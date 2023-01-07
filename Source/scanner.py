# made adapting code from: 
# - https://java2blog.com/python-read-file-into-string/
# - https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch06s01.html
# - https://stackoverflow.com/questions/9519734/python-regex-to-find-a-string-in-double-quotes-within-a-string
# - https://www.digitalocean.com/community/tutorials/python-string-contains
# - https://datatofish.com/executable-pyinstaller/

import re
import sys
from RursusToken import RursusToken


#TODO:
#- Must further separate punctuation after using the word_tokenize() method. Currently there must be spaces between characters and punctuation so they are separated in some cases
#   this additional processing must be done at the start

#OBSERVATIONS
#- Doing it this way modifies the content of strings by deleting spaces, newlines, etc. It assumes there is a single space between all tokens.

#incrementum y decrementum las categoricé como palabras reservadas
OPERATIONS = [ "<", ">", "=", ">=", "<=", "><", "[>>]", "[<<]", "[&?]", "[#?]", "$\+", "\$\#", r'[*]$[*]\|\>[*]', r'[*]$[*]|<[*]', r'[*]$\?[*]', 
            "\+", "\-", "\*", "%", "/", "\:=", "\+=", "\*=", "%=", "\/=", "\:", "addere", "necar", "unionis", "intersectio", "pertinet", "vacua",
            "patentibus", "prope", "scripturam", "lectio", "partum", "ligo", ">>", "<<"]

RESERVED = ["incrementum", "decrementum", "numerus", "imago", "catena", "dualis", "statuo", "liber", "ordo", "autem", 
            "conjugo", "dixi", "firmamentum", "detrimentum", "casus", "neco", "finis", "aeger", "initum", "opus", 
            "dixi", "itero", "usque", "sigla", "panis", "auctum", "gradus", "tempus", "certus", "mentiri", "pergo", 
            "claudeo", "directus", "est", "sum", "dito", "nomen", "perpetuus", "furibundus", "commutabilis", "exemplar", 
            "corpus", "in","\.", "\,", "\(","\)","\[","\]","\{","\}"]

INTEGERS = r'[\-]?\b[0-9]+\b' #Family 0

IDENTIFIERS = "[\w\-]+" #Family 1

#Characters will be family 2

#Strings will be family 3

ERRORLIST = []

TOKENOBJECTLIST = []

statistics = [["OPERATIONS",0],["RESERVED",0],["INTEGERS",0],["IDS",0],["STRINGS",0], ["CHARACTERS",0], ["ERRORS",0]]

#This function completely eliminates comments from the text it receives
def removeComments(pTokenList):
    resultTokenList = []
    commenting = False
    for i in range(0,len(pTokenList)):
        if pTokenList[i]=="<" and pTokenList[i+1]=="#":
            commenting = True
        elif pTokenList[i-1]=="#" and pTokenList[i]==">":
            #i+=2
            commenting = False
        else:
            if not commenting:
                resultTokenList+=[pTokenList[i]]
    return resultTokenList

def separateDots(pTokenList):
    resultTokenList = []
    





#This function will join elements that belong to the same string
def checkStrings(pTokenList, pTokenPos):
    global TOKENOBJECTLIST
    nextTokenPos=pTokenPos + 1
    if pTokenList[pTokenPos]=='``':
        pTokenList[pTokenPos] = '"'

        while pTokenList[nextTokenPos] != "''":
            #print(pTokenList[nextTokenPos])
            pTokenList[pTokenPos] += pTokenList[nextTokenPos]
            if pTokenList[nextTokenPos+1] != "''":
                pTokenList[pTokenPos] += " "
            pTokenList.pop(nextTokenPos)

        pTokenList.pop(nextTokenPos)
        pTokenList[pTokenPos] += '"'
        statistics[4][1] += 1
        TOKENOBJECTLIST += [RursusToken(pTokenList[pTokenPos], 3, "Str")]
        return [pTokenList, True]

    return [pTokenList, False]

#This function will join elements that belong to the same character
def checkCharacters(pTokenList,pTokenPos):
    global TOKENOBJECTLIST
    nextTokenPos=pTokenPos + 1

    if pTokenList[pTokenPos] == "'":
        pTokenList[pTokenPos] += pTokenList[nextTokenPos]
        

        if pTokenList[nextTokenPos] != "'":
            pTokenList.pop(nextTokenPos)
            pTokenList[pTokenPos] += pTokenList[nextTokenPos]

            if pTokenList[nextTokenPos] != "'":
                global ERRORLIST
                ERRORLIST += [(pTokenPos, pTokenList[nextTokenPos])]
                print("Error de caracter en el token #", pTokenPos, ' El token es: "',pTokenList[pTokenPos],'", Codigo de error: 101')
                sys.exit()
                #statistics[6][1] +=1
                #pTokenList.pop(nextTokenPos)
                #return [pTokenList, True]

            pTokenList.pop(nextTokenPos)
        statistics[5][1] +=1
        TOKENOBJECTLIST += [RursusToken(pTokenList[pTokenPos], 2, "Char")]
        return [pTokenList, True]
        
    return [pTokenList, False]

#This function will match the reserved words and count how many there are
def checkReserved(pToken):
    global TOKENOBJECTLIST
    #for regEx in RESERVED:
    for i in range(0, len(RESERVED)):
        exResult = re.findall(RESERVED[i], pToken, re.IGNORECASE)
        if len(exResult)==1:
            statistics[1][1] += 1
            TOKENOBJECTLIST += [RursusToken(pToken, i+len(OPERATIONS) + 4, "Reserved")]
            return True
    return False

def checkOperations(pTokenList,pTokenPos):
    global TOKENOBJECTLIST
    nextTokenPos = pTokenPos + 1
    #for regEx in OPERATIONS:
    for i in range(0, len(OPERATIONS)):
        exResult1 = re.findall(OPERATIONS[i], pTokenList[pTokenPos], re.IGNORECASE)
        if nextTokenPos < len(pTokenList):
            exResult2 = re.findall(OPERATIONS[i], pTokenList[nextTokenPos], re.IGNORECASE)
        else:
            exResult2=[]
        if (len(exResult1)>0) and (len(exResult2)>0):
            pTokenList[pTokenPos] += pTokenList[nextTokenPos]
            pTokenList.pop(nextTokenPos)
            statistics[0][1] += 1
            TOKENOBJECTLIST += [RursusToken(pTokenList[pTokenPos], i+4, "Operation")]
            return [pTokenList, True]

        elif (len(exResult1)>0):
            statistics[0][1] += 1
            return [pTokenList, True]
    
    return [pTokenList, False]

def checkIntegers(pTokenList, pTokenPos):
    global TOKENOBJECTLIST
    exResult = re.findall(INTEGERS, pTokenList[pTokenPos])
    
    if len(exResult)>0:
        statistics[2][1] += 1
        TOKENOBJECTLIST += [RursusToken(pTokenList[pTokenPos], 0, "Int")]
        return True
    return False

def checkIdentifiers(pTokenList, pTokenPos):
    global TOKENOBJECTLIST
    exResult = re.findall(IDENTIFIERS, pTokenList[pTokenPos], re.IGNORECASE)
    if (len(exResult)>0):
        statistics[3][1] += 1
        TOKENOBJECTLIST += [RursusToken(pTokenList[pTokenPos], 1, "Id")]
        return True
    statistics[6][1] += 1
    global ERRORLIST
    ERRORLIST += [(pTokenPos, pTokenList[pTokenPos])]
    print("Error de identificador en el token #", pTokenPos, ' El token es: "',pTokenList[pTokenPos],'", Codigo de error: 100')
    sys.exit()
    return False

#This function will join tokens that should be one and count the amount of each category of tokens there is
def cleanTokens(pTokenList):
    resultTokenList = []
    result=False
    tokenPos=0
    while (tokenPos < len(pTokenList)):
        result=False
        #Checks for strings
        [pTokenList,result] = checkStrings(pTokenList,tokenPos)
        if result == True:
            tokenPos += 1
            continue

        #Checks for characters
        [pTokenList,result] = checkCharacters(pTokenList,tokenPos)
        if result == True:
            tokenPos += 1
            continue

        #checks for operations
        [pTokenList,result] = checkOperations(pTokenList,tokenPos)
        if result == True:
            tokenPos += 1
            continue
        
        #check for reserved tokens
        result = checkReserved(pTokenList[tokenPos])
        if result == True:
            tokenPos += 1
            continue

        #check for integers
        result = checkIntegers(pTokenList, tokenPos)
        if result == True:
            tokenPos += 1
            continue

        #check for identifiers
        result = checkIdentifiers(pTokenList, tokenPos)
        if result == True:
            tokenPos += 1
            continue


        tokenPos += 1
        print(tokenPos)   
    return pTokenList


#para correr sin convertir a .exe
"""
with open('prueba3.rur','r') as file:
    script = file.read()

tokenList = word_tokenize(script)

tokenList = removeComments(tokenList)
print("numero de tokens sin comments: ", len(tokenList))

tokenList = cleanTokens(tokenList)
print(tokenList)

print("numero de tokens luego de limpieza: ", len(tokenList))
print("Estadisticas: ", statistics)

print(ERRORLIST)
"""

#para convertir a .exe
"""
if __name__ == "__main__":
    if len(sys.argv)>1:
        with open(sys.argv[1],'r') as file:
            script = file.read()

        tokenList = word_tokenize(script)

        tokenList = removeComments(tokenList)
        print("numero de tokens sin comments: ", len(tokenList))

        tokenList = cleanTokens(tokenList)

        print(tokenList)
        print("numero de tokens luego de limpieza: ", len(tokenList))
        for statistic in statistics:
            if (statistic[1] != 0):
                print(statistic)

        print(ERRORLIST)
"""