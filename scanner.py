# made adapting code from: 
# - https://java2blog.com/python-read-file-into-string/
# - https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch06s01.html
# - https://stackoverflow.com/questions/9519734/python-regex-to-find-a-string-in-double-quotes-within-a-string

import nltk
import re


#TODO:
#- Further verification for strings and char is necessary
#- Must further separate punctuation after using the word_tokenize() method. Currently there must be spaces between characters and punctuation so they are separated in some cases
#- It also modifies the content of strings by deleting spaces, newlines, etc. It assumes there is a single space between all tokens.

#incrementum y decrementum las categoricé como palabras reservadas
OPERATIONS=[ "<", ">", "=", ">=", "<=", "><", "[>>]", "[<<]", "[&?]", "[#?]", "$\+", "\$\#", r'[*]$[*]\|\>[*]', r'[*]$[*]|<[*]', r'[*]$\?[*]', 
            "\+", "\-", "\*", "%", "/", "\:=", "\+=", "\*=", "%=", "/="]

RESERVED=["incrementum", "decrementum", "numerus", "imago", "catena", "dualis", "statuo", "liber", "ordo", "autem", 
            "conjugo", "dixi", "firmamentum", "detrimentum", "casus", "neco", "finis", "aeger", "initum", "opus", 
            "dixi", "itero", "usque", "sigla", "panis", "auctum", "gradus", "tempus", "certus", "mentiri", "pergo", 
            "claudeo", "directus", "est", "sum", "dito", "nomen", "perpetuus", "furibundus", "commutabilis", "exemplar", "corpus"]

INTEGERS=r'[+-]?\b[0-9]+\b'

STRINGS= r'"(.*?)"'

IDENTIFIER = "[\w\-]+"

statistics = [["OPERATIONS",0],["RESERVED",0],["INTEGERS",0],["IDS",0],["STRINGS",0], ["CHARACTERS",0], ["ERRORS",0]]

errorList = []

with open('ejemploDelProfe.rur','r') as file:
    script = file.read()

tokenList = nltk.word_tokenize(script)

#This function completely eliminates comments from the text it receives
def removeComments(pTokenList):
    resultTokenList = []
    commenting = False
    for i in range(0,len(pTokenList)-2):
        if pTokenList[i]=="<" and pTokenList[i+1]=="#":
            commenting = True
        elif pTokenList[i]=="#" and pTokenList[i+1]==">":
            commenting = False
        else:
            if not commenting:
                resultTokenList+=[pTokenList[i]]
    return resultTokenList





#This function will match with the reserved words and count how many there are
def checkReserved(pToken):
    for regEx in RESERVED:
        exResult = re.findall(regEx, pToken, re.IGNORECASE)
        if len(exResult)==1:
            statistics[1][1]+=1
            return True
    return False

def checkStrings(pTokenList, pTokenPos):
    tokenPos=pTokenPos
    if pTokenList[pTokenPos]=='``':
        pTokenList[pTokenPos] = '"'
        tokenPos += 1
        while pTokenList[tokenPos] != "''":
            print(pTokenList[tokenPos])
            pTokenList[pTokenPos] += pTokenList[tokenPos]
            pTokenList.pop(tokenPos)
            #tokenPos += 1
        pTokenList.pop(tokenPos)
        pTokenList[pTokenPos] += '"'
        statistics[4][1] += 1
        return [pTokenList, True]
    return [pTokenList, False]

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
        
        #check for reserved tokens
        result = checkReserved(pTokenList[tokenPos])
        if result == True:
            tokenPos += 1
            continue
        tokenPos += 1
            
            


    return pTokenList


tokenList = removeComments(tokenList)
print(tokenList)
print("numero de tokens sin comments: ", len(tokenList))


tokenList = cleanTokens(tokenList)

print(tokenList)
print("numero de tokens luego de limpieza: ", len(tokenList))
print("Estadisticas: ", statistics)