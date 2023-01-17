# made adapting code from:
# -https://www.geeksforgeeks.org/compiler-design-ll1-parser-in-python/

import sys
import Scanner
import main
from RursusToken import RursusToken

# TODO(s) remaining:

STACK = []
TOKENLIST = []
PARSINGTABLE = []


def popToken():
    global TOKENLIST
    if len(TOKENLIST) > 0:
        return TOKENLIST.pop(0)
    else:
        return RursusToken("EOF", -2, "Id")


# TODO: definir lógica


def checkTable(pCurrentToken):
    if (PARSINGTABLE[pCurrentToken.family] != -1):
        print("a")
        return True
    else:
        return False


def parseTokens(pTokenList, pParsingTable):
    global TOKENLIST, STACK, PARSINGTABLE
    TOKENLIST = pTokenList
    PARSINGTABLE = pParsingTable
    currentToken = popToken()
    while(currentToken.family != -2):
        if (currentToken.family == -1):
            print("Error sintáctico, Token received: ",
                  currentToken.content, " -> ", currentToken.family)
        else:
            currentToken = popToken()


# When running file without converting to .exe
