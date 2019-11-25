import math
"""
State diagram representation

"""
""" Convert a decimal number in a string to a binary number in string
	num		: the number
	width	: the width of the returned value.
				if num is longer than length width specifies
				higher significant bits will be truncated
				Ex: strD2B('7',2) => '01'
				if it is shorter than length width specifies
				0s will be padded to the left
"""
def strD2B(num,width=None):
	biNum=bin(num)
	noPreB=biNum[2:]	# Get rid of prefix 0b
	if width != None:	# Is width specified?
		# Yes
		if len(noPreB) > width:	# is the current value longer than width?
			# it is longer, so truncate it
			noPreB=noPreB[len(noPreB)-width:]
		elif len(noPreB) < width: # is the current value shorter than width?
			# it is shorter, so pad it with 0s on the left
			noPreB=((width-len(noPreB))*'0')+noPreB
	return noPreB 
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
"""
class Mchine():
	def __init__(self):
		self.mType=mType
"""
class MealyStateDiagram:				
	"""
		Input value take 
		_mType is "Mo" or "Me"
		_StateBank is a dictionary of dictionary
			key =========================================>> value
			decimal(StateIndex)					dictionary(key(inputputBitString)=>Value(tuple(NextstateIndex,Output))
		_IntBitTTb is a list of dictionary
			_IntBitTTB[bitN]= Dictionary representing truth table of the bit
				Dictionary(key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+='0' or '1' or 'x'(don't care)))

	"""
	def __init__(self,fileName):
			self._mType="NotSet"
			self._numState=0					# Number of State
			self._numInp=0						# Number of inputs
			self._numOut=0						# Number of outputs
			self._numIntBit=0					# Number of internal bit to represent state
			self._StateBank={}					# The collection of state object
			self._IntBitTTb=[]					# The collection of internal bit next state truth table
			self._MainTTb={}					# The main truth table where left side are current state
												# and right side are next state of each bit
			try:
				self.parseNBuildStateBank(fileName)	# Build the StateBank
				self.buildMainTTb()					# Build the main truth table for all bit
				self.buildIntBitTTb()				# Built the truth table for each bit
			except ValueError as e:
				print('Some error encountered:'+str(e))

	def parseNBuildStateBank(self,fname):
		"""Parse the input file to create the _StateBank"""
		f=open(fname,'r')
		# Read number input,output and state
		self._mType=f.readline().rstrip('\n')
		self._numInp=int(f.readline())
		self._numOut=int(f.readline())
		self._numState=int(f.readline())
		self._numIntBit=max(1,math.ceil(math.log(self._numState,2)))	# Preventing the case _numState=1
		# Read each state
		totalLink=0		# Reset link counter
		i=0
		while i<=self._numState:
			pos=f.tell()
			line=f.readline().rstrip('\n')
			parsedLine=line.split()
			if len(parsedLine)==0:	# Is it end of file ?
				#yes
				break
			elif len(parsedLine) == 1:			# Is this a state line or a state's connection line?
				#This is state line
				stateIndex=int(line)
				self._StateBank[stateIndex]={}
				i=i+1
				if totalLink!=0:
					if totalLink < 2**self._numInp:
						print('Need more link: State {} has {} links, but need {}'.format(stateIndex-1,totalLink,2**self._numInp))
						raise ValueError('Error building main truth table')
					elif totalLink > 2**self._numInp:
						print('Too many link: State {} has {} links, but need {}'.format(stateIndex-1,totalLink,2**self._numInp))
						raise ValueError('Error building main truth table')
				totalLink=0					# Reset state link counter
			else:
				# This is state's connection line					
				# Read connection of each state
				nextStateIndex=int(parsedLine[0])
				del parsedLine[0]
				for j in parsedLine:
					InpCommaOut=j.split(',')
					if InpCommaOut[0] in self._StateBank[stateIndex].keys():	# Is this input sequence already added?
						# Already added, so spit out error
						print('Duplicated input sequence: State {}, next state {}, {} input sequence duplicated'.format(stateIndex,nextStateIndex,InpCommaOut[0]))
						raise ValueError('Error building main truth table')
					else:
						self._StateBank[stateIndex][InpCommaOut[0]]=(nextStateIndex,InpCommaOut[1])
					totalLink+=1
		# When the loop exit, the file cursor is at the test input
		# So back up
		f.seek(pos)

	def buildIntBitTTb(self):
		""" build the truth table for each bit
			_InBitTTb[bit0,bit1,bit2..]
			_InBitTTb[bitN]=Dictionary(key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+ = '0' or '1' or' x'))
		"""
		self._IntBitTTb=[{} for i in range(self._numIntBit)]	# Make an empty dictionary for each bit
		leftSide=list(self._MainTTb.keys())						# Get all possible input
		leftSide.sort()					# Make input ascending order (0..0 ,0..1 ,.0..10,..)
		for b in range(self._numIntBit):			# Loop through each internal bit and build truth table for such bit
			for inp in leftSide:
				self._IntBitTTb[b][inp]=self._MainTTb[inp][b]	#Getting the right side corresponding row of the main truth table and extract the bit out

	def buildMainTTb(self):
		""" Build the _MainTTb table
			Format is to have
			_MainTTB[key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+ = '0' or '1' or 'x')]
		"""
		for state in range(2**self._numIntBit):	# Loop though each binarystring representing states
			# There are potentially bitstrings that are not used.
			# Ex, if you have 3 states
			# you need 4 internal bits but only use up to 10.
			# The 11 is not used, therefore seen as don't care values
			internalBit=strD2B(state,width=self._numIntBit)	#Bit0Bit1..BitN
			if state in self._StateBank.keys():	# Is this a defined state?
				# Yes
				# Building the left side of the truth table
				# Getting the Input0Input1...InputN bitstring
				inpBitList=self._StateBank[state].keys()
				for inp in inpBitList:		#Loop through each
					leftSideTruthTTb=internalBit+inp
					self._MainTTb[leftSideTruthTTb]=strD2B(self._StateBank[state][inp][0],width=self._numIntBit)
			else:
				# No this is not a defined state, will be assign don't care
				inpBitList=[strD2B(x,width=self._numInp) for x in range(self._numInp)]			
				for inp in inpBitList:		#Loop through each
					leftSideTruthTTb=internalBit+inp
					self._MainTTb[leftSideTruthTTb]=self._numIntBit*'x'
#=====================================MainProgram=============================================
a=MealyStateDiagram('./test.txt')
X='11001'
nowState=0