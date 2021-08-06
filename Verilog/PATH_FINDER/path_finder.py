import re

filename = "fullAdderGate.v"

f = open(filename,"r")

inputs = []
outputs = []
nodes = [] #adjacency list
path = []

#finds index of a wire,input or output
def findLoc(word1):
    i=0
    for x in nodes:
        if x[0]==word1:
            return i
        else :
            i=i+1
    
def isOutput(word):
    for x in outputs:
        if(x==word):
            return 1
    return 0

def isInput(word):
    for x in inputs:
        if x==word:
            return 1
    return 0

def display():
    x = len(path)-1
    while x>0:
        print(path[x]," --> ",end=""),
        x=x-1
    print(path[x])
    
#recursively searches for each path
def findPath(root):
    l=findLoc(root)
    for i in range(len(nodes[l])-1):
        if(not isInput(nodes[l][i+1])):
            path.append(nodes[l][i+1])
            findPath(nodes[l][i+1])
            path.pop()
        else:
            path.append(nodes[l][i+1])
            display()
            path.pop()
            
     


i = 0
for line in f:
    for word in re.split("[, \,;]+",line):
        #add inputs to inputs[],nodes[]
        if(word == "input"):
            for word in re.split("[, \,;]+",line):
                if(word != "input" and word != "\n"):
                    inputs.append(word)
                    nodes.append([])
                    nodes[i].append(word)
                    i = i+1
        #add outputs to outputs[],nodes[]
        if(word == "output"):
            for word in re.split("[, \,;]+",line):
                if(word != "output" and word != "\n"):

                    outputs.append(word)
                    nodes.append([])
                    nodes[i].append(word)
                    i = i+1
        #add wires to nodes[]
        if(word == "wire"):
            for word in re.split("[, \,;]+",line):
                if(word != "wire" and word != "\n"):
                    nodes.append([])
                    nodes[i].append(word)
                    i = i+1

f.close()


f = open(filename,"r")

for line in f:
    word = re.split("[, \()]+",line)[0]  #holds the first word of a line [gates get stored here]

    if(word == "not"):
        word1 = re.split("[, \()]+",line)[2]        #output variable
        word2 = re.split("[, \()]+",line)[3]        #input variable
        loc = findLoc(word1)
        nodes[loc].append(word2)
        
    if(word=='and' or word == 'or' or word=='xor' or word=='nor' or word=="nand"):
        word1 = re.split("[, \()]+",line)[2]    #output variable
        word2 = re.split("[, \()]+",line)[3]    #input variable 1
        word3 = re.split("[, \()]+",line)[4]    #input variable 2
  
        loc = findLoc(word1)
        nodes[loc].append(word2)
        nodes[loc].append(word3)
            
#display inputs
print("INPUT VARIABLES ARE :")
for x in inputs:
    print(x)
print() 
print("OUTPUT VARIABLES ARE :")
for x in outputs:
    print(x)
print()
print("PATHS FROM INPUT TO OUTPUT :")
for i in range(len(nodes)):
    if(isOutput(nodes[i][0])):      #recusively start search from output variable
        path.append(nodes[i][0])
        findPath(nodes[i][0])
        path.pop()

