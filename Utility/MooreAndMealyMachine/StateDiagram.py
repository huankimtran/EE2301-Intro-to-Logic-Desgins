"""
State diagram representation

"""
"""
	Class represent a state, a node in the state diagram
	_Link is a dictionary
	key  ======================================> value
(binayStringInput)											
"""
class State:
	def __init__(self,StateIndex,LinkBank,MooreStateOutput=0):
		self._StateIndex=StateIndex
		self._Link=LinkBank
		self._StateOutput=MooreStateOutput

class Mchine():
	def __init__(self):
		self.mType=mType
class MealyStateDiagram:
	def parse(self,fname):
			f=open(fname,'r')
			f.readline()	#don't need machine type line
			self._mType=self.mType.rstrip('\n')
			self._numInp=int(f.readline())
			self._numOut=int(f.readline())
			self._numState=int(f.readline())
			for i in range(self._numState):
				stateIndex=int(f.readline())
				line=f.readline()
				line=line.rstrip('\n')
				parsedLine=line.split(
				nextSateIndex=int(parseLine[0])
				
	
	"""
		Input value take 
		mType is "Mo" or "Me"
		StateBank is a dictionary 
			 key =========================================>> value
			BitString(StateIndex)			Moore			tuple(State(NextstateIndex),Output)
																Mealy			tuple(State(NextStateIndex))          
	"""
	def __init__(self,fileName)
			self._mType="NotSet"
			self._numState=0
			self._StateBank={}
			self._numInp=0
			self._numOut=0
			self.parse(fileName)
			
				
	
