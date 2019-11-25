from StateDiagram import *

# File to parse here
stateDiagramDescriptionFile='./test.txt'


# Don't care about below
f=open(stateDiagramDescriptionFile,'r')
line=f.readline()
if line[:-1]=='Me':
	MealyMachine=MealyStateDiagram(stateDiagramDescriptionFile)
else:
	# Complete the Moore!!
	pass