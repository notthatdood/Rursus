import Scanner
from nltk import word_tokenize



#When running file without converting to .exe
with open('prueba3.rur','r') as file:
    script = file.read()

tokenList = word_tokenize(script)

tokenList = Scanner.removeComments(tokenList)
print("numero de tokens sin comments: ", len(tokenList))

tokenList = Scanner.cleanTokens(tokenList)
print(tokenList)

print("numero de tokens luego de limpieza: ", len(tokenList))
print("Estadisticas: ", Scanner.statistics)


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

