import Scanner
from nltk import word_tokenize

def printTokens():
    for i in range(0,len(Scanner.TOKENOBJECTLIST)):
        print("|   |" + Scanner.TOKENOBJECTLIST[i].content + " -> " + Scanner.TOKENOBJECTLIST[i].type," -> " + str(Scanner.TOKENOBJECTLIST[i].family), end = '')
        if (((i+1) % 4 == 0)):
            print("|   | \n")


#When running file without converting to .exe
with open('Source/RursusTestPrograms/prueba3.rur','r') as file:
    script = file.read()

script += "\nEOF"

tokenList = word_tokenize(script)
print("numero de tokens con comments: ", len(tokenList))

tokenList = Scanner.removeComments(tokenList)
print("numero de tokens sin comments: ", len(tokenList))

tokenList = Scanner.cleanTokens(tokenList)

#print(tokenList)
print("numero de tokens luego de limpieza: ", len(tokenList))
print("Estadisticas: ", Scanner.statistics)

printTokens()

#When converting file to .exe
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

