#made adapting code from:
#   -https://www.geeksforgeeks.org/reading-excel-file-using-python/
import math
import pandas

def getGrammar(pFileName):

    ogGrammar = pandas.read_excel(pFileName)
    ogGrammar = ogGrammar.to_numpy().tolist()
    grammar = []
    for i in ogGrammar:
        if type(i[0]) is str:
            grammar = grammar + [i]
    return grammar

#getGrammar("Source/x.xls")