# made adapting code from:
# -https://www.geeksforgeeks.org/compiler-design-ll1-parser-in-python/

import sys
from RursusToken import RursusToken

# TODO(s) remaining:

Stack = []
TokenList = []
ParsingTable = []
Grammar = []
CurrentToken = []
CurrentNonTerminal = 0

def popToken():
    global TokenList
    if len(TokenList) > 0:
        return TokenList.pop(0)
    else:
        return RursusToken("EOF", -2, "Id")


# TODO: definir lógica


def checkTable():
    global ParsingTable, CurrentToken, Stack, Grammar, CurrentNonTerminal
    print("currenttokenfam: ", CurrentToken.family)
    print("currentnt: ", CurrentNonTerminal)
    print("ptresult: ", ParsingTable[CurrentNonTerminal][CurrentToken.family])
    ParsingTable[CurrentNonTerminal]
    CurrentNonTerminal = int(ParsingTable[CurrentNonTerminal][CurrentToken.family])
    if (CurrentNonTerminal != -1):
        print("current nt number: ", CurrentNonTerminal)
        #Here we add the rule's content to the Stack
        Stack = Grammar[CurrentNonTerminal] + Stack
        return True
    else:
        print("Parsing error, Token received: ", CurrentToken.content, " -> ", CurrentToken.family)
        sys.exit()


def parseTokens(pTokenList, pParsingTable, pGrammar):
    global TokenList, Stack, ParsingTable, Grammar, CurrentToken
    TokenList = pTokenList
    ParsingTable = pParsingTable
    Grammar = pGrammar
    CurrentToken = popToken()
    print("parsingtable: ",len(pParsingTable))
    while(CurrentToken.family != -2):
        print("CurrentContent: ",CurrentToken.content)
        checkTable()
        CurrentToken = popToken()
    print("The string is correct!")
    return True
