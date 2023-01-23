import RursusToken
#TODO: analyze operations

TypeList=[]
IdentifierList=[]

def analyzeOperation(pToken):
    print('Operation analysis')
    match pToken.content:
        case "<":
            print(pToken.content, " 1")
        case ">":
            print(pToken.content, " 2")
        case "=":
            print(pToken.content, " 3")
        case ">=":
            print(pToken.content, " 4")
        case "<=":
            print(pToken.content, " 5")
        case "><":
            print(pToken.content, " 6")
        case "\[>>\]":
            print(pToken.content, " 7")
        case "\[<<\]":
            print(pToken.content, " 8")
        case "\[&?\]":
            print(pToken.content, " 9")
        case "\[#?\]":
            print(pToken.content, " 10")
        case "$\+":
            print(pToken.content, " 11")
        case "\$\#":
            print(pToken.content, " 12")
        case "\$":
            print(pToken.content, " 13")
        case r'\|\>':
            print(pToken.content, " 14")
        case r'\|\<':
            print(pToken.content, " 15")
        case r'\$\?':
            print(pToken.content, " 16")
        case "\+":
            print(pToken.content, " 17")
        case "\-":
            print(pToken.content, " 18")
        case "\*":
            print(pToken.content, " 19")
        case "%":
            print(pToken.content, " 20")
        case "\/":
            print(pToken.content, " 21")
        case "\:=":
            print(pToken.content, " 22")
        case "\+=":
            print(pToken.content, " 23")
        case "\*=":
            print(pToken.content, " 24")
        case "%=":
            print(pToken.content, " 25")
        case "\/=":
            print(pToken.content, " 26")
        case "\:":
            print(pToken.content, " 27")
        case "addere":
            print(pToken.content, " 28")
        case "necar":
            print(pToken.content, " 29")
        case "unionis":
            print(pToken.content, " 30")
        case "intersectio":
            print(pToken.content, " 31")
        case "pertinet":
            print(pToken.content, " 32")
        case "vacua":
            print(pToken.content, " 33")
        case "patentibus":
            print(pToken.content, " 34")
        case "prope":
            print(pToken.content, " 35")
        case "scripturam":
            print(pToken.content, " 36")
        case "lectio":
            print(pToken.content, " 37")
        case "partum":
            print(pToken.content, " 38")
        case "ligo":
            print(pToken.content, " 39")
        case ">>":
            print(pToken.content, " 40")
        case "<<":
            print(pToken.content, " 41")
        case _:
            print(pToken.content, "default")



#TODO: analyze reserved
def analyzeReserved(pToken):
    print("Reserved analysis")
    match pToken.content:
        case "incrementum":
            print(pToken.content, " 42")
        case "decrementum":
            print(pToken.content, " 43")
        case "numerus":
            print(pToken.content, " 44")
        case "imago":
            print(pToken.content, " 45")
        case "catena":
            print(pToken.content, " 46")
        case "dualis":
            print(pToken.content, " 47")
        case "statuo":
            print(pToken.content, " 48")
        case "liber":
            print(pToken.content, " 49")
        case "ordo":
            print(pToken.content, " 50")
        case "autem":
            print(pToken.content, " 51")
        case "conjugo":
            print(pToken.content, " 52")
        case "dixi":
            print(pToken.content, " 53")
        case "firmamentum":
            print(pToken.content, " 54")
        case "detrimentum":
            print(pToken.content, " 55")
        case "casus":
            print(pToken.content, " 56")
        case "neco":
            print(pToken.content, " 57")
        case "finis":
            print(pToken.content, " 58")
        case "aeger":
            print(pToken.content, " 59")
        case "initum":
            print(pToken.content, " 60")
        case "opus":
            print(pToken.content, " 61")
        case "itero":
            print(pToken.content, " 62")
        case "usque":
            print(pToken.content, " 63")
        case "sigla":
            print(pToken.content, " 64")
        case "panis":
            print(pToken.content, " 65")
        case "auctum":
            print(pToken.content, " 66")
        case "gradus":
            print(pToken.content, " 67")
        case "tempus":
            print(pToken.content, " 68")
        case "certus":
            print(pToken.content, " 69")
        case "mentiri":
            print(pToken.content, " 70")
        case "pergo":
            print(pToken.content, " 71")
        case "claudeo":
            print(pToken.content, " 72")
        case "directus":
            print(pToken.content, " 73")
        case "est":
            print(pToken.content, " 74")
        case "sum":
            print(pToken.content, " 75")
        case "dito":
            print(pToken.content, " 76")
        case "nomen":
            print(pToken.content, " 77")
        case "perpetuus":
            print(pToken.content, " 78")
        case "furibundus":
            print(pToken.content, " 79")
        case "commutabilis":
            print(pToken.content, " 80")
        case "exemplar":
            print(pToken.content, " 81")
        case "corpus":
            print(pToken.content, " 82")
        case "in":
            print(pToken.content, " 83")
        case "veridicus":
            print(pToken.content, " 84")
        case "falsidicus":
            print(pToken.content, " 85")
        case "\.":
            print(pToken.content, " 86")
        case "\,":
            print(pToken.content, " 87")
        case "\(":
            print(pToken.content, " 88")
        case "\)":
            print(pToken.content, " 89")
        case "\[":
            print(pToken.content, " 90")
        case "\]":
            print(pToken.content, " 91")
        case "\{":
            print(pToken.content, " 92")
        case "\}":
            print(pToken.content, " 93")
        case "efficio":
            print(pToken.content, " 94")
        case _:
            print(pToken.content, "default")

def checkBothSides(CheckedTokenList, TokenList):
    if (((CheckedTokenList[0].type=="Operation") or (CheckedTokenList[0].type=="Id")) and ((TokenList[0].type=="Operation") or (TokenList[0].type=="Id"))):
        return True
    return False


#TODO: analyze IDs
# Checks if the token is in the tokenList
def usesType(pToken):
    global TypeList
    if (pToken.content.lower() in TypeList):
        return True
    return False

# Checks if the token is within the type declaring section
def declaresType(pToken, pTokenList):
    for i in pTokenList:
        if (i.content=="commutabilis"):
            return True
    return False
# Checks if the token is in the tokenList
def usesID(pToken):
    global IdentifierList
    if (pToken.content.lower() in IdentifierList):
        return True
    return False

# Checks if the token is within the variable declaring section
def declaresID(pToken, pTokenList):
    for i in pTokenList:
        if (i.content=="exemplar"):
            return True
    return False

def analyzeId(pToken):
    if (usesType(pToken)):
        return True
    elif (declaresType(pToken)):
        return True
    elif (usesID(pToken)):
        return True
    elif (declaresID(pToken)):
        return True
    return False
