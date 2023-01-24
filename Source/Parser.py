# made adapting code from:
# -https://www.geeksforgeeks.org/compiler-design-ll1-parser-in-python/

import sys
from RursusToken import RursusToken
import Semantic

# TODO(s) remaining:

Stack = []
TokenList = []
ParsingTable = []
Grammar = []
NonTerminalList = []
CurrentToken = []
CurrentNonTerminal = 0
Top = ""
CheckedTokenList = []

def popToken():
    global TokenList, CheckedTokenList
    if len(TokenList) > 0:
        popped = TokenList.pop(0)
        CheckedTokenList = [popped] + CheckedTokenList
        return popped
    else:
        return RursusToken("EOF", -2, "Id")


def createNonTerminalList():
    global Grammar, NonTerminalList
    for rule in Grammar:
        if (rule[0] not in NonTerminalList):
            NonTerminalList += [rule[0]]


#This funciton will try to match the token
def matchTokens():
    global ParsingTable, CurrentToken, Stack, Grammar, CurrentNonTerminal, NonTerminalList, Top
    print("currentToken: ", CurrentToken.content, " family: ", CurrentToken.family)
    while (Top not in NonTerminalList):
        print("###############################################################################")
        print("StackIn: ", Stack)
        print("TopIn: ", Top)
        if (Top == CurrentToken.content):
            print("matched: ", CurrentToken.content, "with : ", Top)
            CurrentToken = popToken()
            if(len(Stack)==0):
                break
            Top = Stack.pop(0)
            
        elif ((CurrentToken.family == 0) and Top == "entero"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            CurrentToken = popToken()
            if(len(Stack)==0):
                break
            Top = Stack.pop(0)
            
        elif ((CurrentToken.family == 1) and Top == "id"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            #This is to catch undefined types and identifiers but undefined type catching doesn't work 
            if (not (Semantic.usesType(CurrentToken)) and not (Semantic.declaresType(CurrentToken, TokenList))):
                if (not (Semantic.usesID(CurrentToken)) and not (Semantic.declaresID(CurrentToken, TokenList))):
                    print("Parsing error")
                    print("Token received: ", CurrentToken.content, " | token's family: ", CurrentToken.family)
                    print("Token is not a defined type or identifier")
                    sys.exit()
            CurrentToken = popToken()
            if(len(Stack)==0):
                break
            Top = Stack.pop(0)
            
        elif ((CurrentToken.family == 2) and Top == "caracter"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            CurrentToken = popToken()
            if(len(Stack)==0):
                break
            Top = Stack.pop(0)
            
        elif ((CurrentToken.family == 3) and Top == "strings"):
            print("matched: ", CurrentToken.content, "with : ", Top)
            CurrentToken = popToken()
            if(len(Stack)==0):
                break
            Top = Stack.pop(0)
            
        else:
            print("Parsing error")
            print("Token received: ", CurrentToken.content, " | token's family: ", CurrentToken.family)
            print("Token expected: ", Top)
            sys.exit()
        
    Stack = [Top] + Stack 
    if((len(Stack)>0) and (Top in NonTerminalList)):
        CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
        
    print("###############################################################################*")

# TODO: aplicar lógica del stack
def checkTable():
    global ParsingTable, CurrentToken, Stack, Grammar, CurrentNonTerminal, NonTerminalList, Top
    Stack = ['<S>']
    
    #Top = Stack.pop(0)
    #CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
    #Stack = Grammar[CurrentNonTerminal][2:] + Stack
    print("Stack: ", Stack)
    while(CurrentToken.family != -2):
        if (CurrentNonTerminal == -1):
            print("Parsing error, Token received: ", CurrentToken.content, " -> ", CurrentToken.family)
            sys.exit()

        print("\n\n---------------------------------------------------------------")
        Top = Stack.pop(0)
        

        #Here we add the rule's content to the Stack
        
        
        if (Top not in NonTerminalList):
            matchTokens()
            
        else:
            print("currentToken: ", CurrentToken.content, " family: ", CurrentToken.family)
            CurrentNonTerminal = int(ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
            print("Top: ", Top, "Index: ", ParsingTable[NonTerminalList.index(Top)][CurrentToken.family])
            Stack = Grammar[CurrentNonTerminal][2:] + Stack
        print("Stack: ", Stack)
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


