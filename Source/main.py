import Scanner
import Parser
import parseParsingTable
from nltk import word_tokenize

def printTokens():
    for i in range(0,len(Scanner.TOKENOBJECTLIST)):
        print("|   |" + Scanner.TOKENOBJECTLIST[i].content + " -> " + Scanner.TOKENOBJECTLIST[i].type," -> " + str(Scanner.TOKENOBJECTLIST[i].family), end = '')
        if (((i+1) % 4 == 0)):
            print("|   | \n")


#When running file without converting to .exe
with open('Source/RursusTestPrograms/prueba3.rur','r') as file:
    script = file.read()

tokenList = word_tokenize(script)

#print("Total tokens with comments: ", len(tokenList))

tokenList = Scanner.removeComments(tokenList)

#print("Total tokens without comments: ", len(tokenList))

tokenList = Scanner.cleanTokens(tokenList)

#Uncomment this section to see some statistics of the tokenization process like number of integers, identifiers, etc...
#print("numero de tokens luego de limpieza: ", len(tokenList))
#print("Estadisticas: ", Scanner.statistics)

#printTokens()


parsingTable = parseParsingTable.getParsingTable("Source\GTablaParsing.java")

for i in range(0,len(parsingTable)):
    parsingTable[i] = parsingTable[i].split(",")

print(parsingTable)

#####################################################





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

