# made adapting code from:
# -https://www.geeksforgeeks.org/compiler-design-ll1-parser-in-python/

import sys
from RursusToken import RursusToken

# TODO(s) remaining:

Stack = []
TokenList = []
ParsingTable = []
Grammar = []
NonTerminalList = []
CurrentToken = []
CurrentNonTerminal = 0
Top = ""

def popToken():
    global TokenList
    if len(TokenList) > 0:
        return TokenList.pop(0)
    else:
        return RursusToken("EOF", -2, "Id")


def createNonTerminalList():
    global Grammar, NonTerminalList
    for rule in Grammar:
        if (rule[0] not in NonTerminalList):
            NonTerminalList += [rule[0]]


#This funciton will try to match the token
def matchTokens():
    global CurrentToken, Stack, Top
    while (Top not in NonTerminalList):
        print("###############################################################################")
        print("StackIn: ", Stack)
        print("TopIn: ", Top)
        if (Top == CurrentToken.content):
            print("matched: ", CurrentToken.content, "with : ", Top)
            Top = Stack.pop(0)
            CurrentToken = popToken()
        elif ((CurrentToken.family == 0) and Top == "entero"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            Top = Stack.pop(0)
            CurrentToken = popToken()
        elif ((CurrentToken.family == 1) and Top == "id"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            Top = Stack.pop(0)
            CurrentToken = popToken()
        elif ((CurrentToken.family == 2) and Top == "caracter"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            Top = Stack.pop(0)
            CurrentToken = popToken()
        elif ((CurrentToken.family == 3) and Top == "string"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            Top = Stack.pop(0)
            CurrentToken = popToken()
        else:
            print("Parsing error")
            print("Token received: ", CurrentToken.content, " | token's family: ", CurrentToken.family)
            print("Token expected: ", Top)
            sys.exit()
    Stack = [Top] + Stack 
    print("###############################################################################*")

# TODO: aplicar lógica del stack
def checkTable():
    global ParsingTable, CurrentToken, Stack, Grammar, CurrentNonTerminal, NonTerminalList, Top
    Stack = ['<S>']
    
    #Top = Stack.pop(0)
    #CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
    #Stack = Grammar[CurrentNonTerminal][2:] + Stack
    while(CurrentToken.family != -2):
        if (CurrentNonTerminal == -1):
            print("Parsing error, Token received: ", CurrentToken.content, " -> ", CurrentToken.family)
            sys.exit()

        print("---------------------------------------------------------------")
        Top = Stack.pop(0)
        

        #Here we add the rule's content to the Stack
        print("Stack: ", Stack)
        print("currentToken: ", CurrentToken.content, " family: ", CurrentToken.family)
        if (Top not in NonTerminalList):
            matchTokens()
            #CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
        else:
            CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
            print("Top: ", Top, "Index: ", ParsingTable[11][95])
            Stack = Grammar[CurrentNonTerminal][2:] + Stack
    #return True
        
    


def parseTokens(pTokenList, pParsingTable, pGrammar):
    global TokenList, Stack, ParsingTable, Grammar, CurrentToken
    TokenList = pTokenList
    ParsingTable = pParsingTable
    Grammar = pGrammar
    createNonTerminalList()
    #print("NonTerminalList: ",len(NonTerminalList))
    CurrentToken = popToken()
    #print("parsingtable: ",len(pParsingTable))

    checkTable()


    print("The string is correct!")
    return True
