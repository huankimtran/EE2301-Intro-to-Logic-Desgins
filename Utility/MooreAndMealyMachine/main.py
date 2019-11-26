import MealyStateDiagram as MeDFF
import MealyStateDiagramJKFF as MeJKFF
import MooreStateDiagram as MoDFF

# File to parse here
stateDiagramDescriptionFile='./Test6.txt'
#stateDiagramDescriptionFile='./MoTest1.txt'


# Don't care about below
f=open(stateDiagramDescriptionFile,'r')
line=f.readline()
DorJK=input('Do you want JKFF or DFF implementation? (DFF/JKFF): ')
if line[:-1]=='Me':
	if DorJK=='DFF':
		Machine=MeDFF.MealyStateDiagram(stateDiagramDescriptionFile)
	else:
		Machine=MeJKFF.MealyStateDiagram(stateDiagramDescriptionFile)
else:
	# Complete the Moore!!
	if DorJK=='DFF':
		Machine=MoDFF.MooreStateDiagram(stateDiagramDescriptionFile)
	else:
		Machine=MoJKFF.MooreStateDiagram(stateDiagramDescriptionFile)