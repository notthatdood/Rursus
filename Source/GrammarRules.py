#made adapting code from:
#   -https://www.geeksforgeeks.org/reading-excel-file-using-python/
import pandas

def getGrammar(pFileName):

    ogGrammar = pandas.read_excel(pFileName)
    ogGrammar = ogGrammar.to_numpy().tolist()
    grammar = []
    for i in ogGrammar:
        if type(i[0]) is str:
            rule=[]
            for j in i:
                if type(j) is str:
                    rule +=[j]
            grammar = grammar + [rule]
    return grammar

#getGrammar("Source/x.xls")