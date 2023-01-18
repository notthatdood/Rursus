import Scanner
import Parser
import cleanParsingTable
import cleanRightSides
import GrammarRules
from nltk import word_tokenize

# TODO:
#    -(NTH) Pass parsing table file as a parameter or remove the need for it if possible


def printTokens():
    for i in range(0, len(Scanner.TOKENOBJECTLIST)):
        print("|   |" + Scanner.TOKENOBJECTLIST[i].content + " -> " +
              Scanner.TOKENOBJECTLIST[i].type, " -> " + str(Scanner.TOKENOBJECTLIST[i].family), end='')
        if (((i+1) % 4 == 0)):
            print("|   | \n")

# When running file without converting to .exe
def main():
    parsingTable = cleanParsingTable.getParsingTable(
        "Source\GTablaParsing.java")
    rightSidesTable = cleanRightSides.getRightSidesTable(
        "Source\GTablaParsing.java")
    # Scanner section-------------------------------------------------------------------------------------------------------
    with open('Source/RursusTestPrograms/prueba3.rur', 'r') as file:
        script = file.read()
    tokenList = word_tokenize(script)

    tokenList = Scanner.removeComments(tokenList)

    Scanner.cleanTokens(tokenList)
    #printTokens()
    # Uncomment this section to see some statistics of the tokenization process like number of integers, identifiers, etc...
    #print("Tokens after cleanup: ", len(Scanner.TOKENOBJECTLIST))
    #print("Estadisticas: ", Scanner.statistics)
    # Parser section--------------------------------------------------------------------------------------------------------
    print(Parser.parseTokens(Scanner.TOKENOBJECTLIST, parsingTable, GrammarRules.getGrammar("Source/Grammar.xls")))


main()
# When converting file to .exe
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
