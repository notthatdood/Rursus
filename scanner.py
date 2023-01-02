# made using code from: 
# - https://java2blog.com/python-read-file-into-string/
# -

import nltk

with open('ejemploDelProfe.rur','r') as file:
    script = file.read()
#print(script)

tokenList = nltk.word_tokenize(script)
print("largo tokens: ", len(tokenList))

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

tokenList = removeComments(tokenList)
print(tokenList)