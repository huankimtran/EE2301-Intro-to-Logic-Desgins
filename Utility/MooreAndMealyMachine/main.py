import MealyStateDiagram as MeDFF
import MealyStateDiagramJKFF as MeJKFF

# File to parse here
stateDiagramDescriptionFile='./test.txt'


# Don't care about below
f=open(stateDiagramDescriptionFile,'r')
line=f.readline()
if line[:-1]=='Me':
	DorJK=input('Do you want JKFF or DFF implementation? (DFF/JKFF): ')
	if DorJK=='DFF':
		Machine=MeDFF.MealyStateDiagram(stateDiagramDescriptionFile)
	else:
		Machine=MeJKFF.MealyStateDiagram(stateDiagramDescriptionFile)
else:
	# Complete the Moore!!
	pass