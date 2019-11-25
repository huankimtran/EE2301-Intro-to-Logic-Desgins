import math
from functions import *
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
			_IntBitTTb[bitN]= Dictionary representing truth table of the bit
				Dictionary(key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+='0' or '1' or 'x'(don't care)))

	"""
	def __init__(self,fileName):
			self._OutPrefix='Z'					# The prefix of output bits (Z0,Z1,..)
			self._InpPrefix='X'					# The prefix of input bits (X0,X1,..)
			self._IntBitPrefix='D'				# The prefix of internal bits (D0,D1,D2...) 
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
			_MainTTb[key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+ = '0' or '1' or 'x')]
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
				inpBitList=[strD2B(x,width=self._numInp) for x in range(2**self._numInp)]
				for inp in inpBitList:		#Loop through each
					leftSideTruthTTb=internalBit+inp
					self._MainTTb[leftSideTruthTTb]=self._numIntBit*'x'

	def getFullLabels(self,nextState=True):
		"""
			Make and return the full lables of each column in _MainTTb
			if nextState=True => right side will be output
			else => right side will be next internal bit
		"""
		leftLables=[self._IntBitPrefix+str(i) for i in range(self._numIntBit)] + [self._InpPrefix+str(i) for i in range(self._numInp)]
		if nextState:
			rightLabels=[self._IntBitPrefix+str(i)+'+' for i in range(self._numIntBit)]
		else:
			rightLabels=[self._OutPrefix+str(i) for i in range(self._numOut)]
		return leftLables+rightLabels

	def printTTb(self,TTb,Labels=None):
		""" 
			Function printing truth table
			TTb is a dictionary with structure like _MainTTb or _IntBitTTb
			Labels is a list containing label for each column in TTb.
			Column in TTb will be assigned to corresponding label in Labels that has the same index
			If Labels = None, assuming Labels is the label of _MainTTb
		"""
		if Labels==None:
			Labels=self.getFullLabels(nextState=True)
		numColumn=len(list(TTb.keys())[0])+len(TTb[list(TTb.keys())[0]])
		maxCoWidth=max([len(x) for x in Labels])
		cFrame ='{{:>{}}}|'.format(maxCoWidth) 
		tableFrame='|'+len(Labels)*cFrame
		print(numColumn*(maxCoWidth+1)*'=')
		print(tableFrame.format(*Labels))				# Using parameter expansion
		print(numColumn*(maxCoWidth+1)*'=')
		for r in TTb.keys():
			print(tableFrame.format(*(r+TTb[r])))
			print(numColumn*(maxCoWidth+1)*'=')

	def solve4Logic(self,TTb):
		"""
			Using the provided library that implement Quine-McCluskey Method
			to solve for logic expression
			TTb is a truth table with left side is all input and right side is
			ONLY ONE variable of which expression will be solved for (aka: something similar to 
			an element of the _IntBitTTb)
			return a list[]=['01-1...','01-1...',...]
		"""
		size=self._numIntBit+self._numInp
		# Parsing minterm from truth table
		minTerm='m({})\n'
		dcTerm='d({})'
		minList=list(map(lambda x:str(int(x,2)),list(filter(lambda x:TTb[x]=='1',list(TTb.keys())))))
		dcList=list(map(lambda x:str(int(x,2)),filter(lambda x:TTb[x]=='x',list(TTb.keys()))))
		function=[size]
		# Is there any min term? this is silly since there are always at least 1 min term but added anw
		if len(minList)>0:
			function.append(minTerm.format(','.join(minList)))
		else:
			function.append('m()')
		# Is there any don't care value?
		if len(dcList)>0:
			# Yes, so add them
			function.append(dcTerm.format(','.join(dcList)))
		print()
		expressionTerms = execute(function, size)
#		printExpression(size, expressionTerms)
		return expressionTerms

	def toExpression(self,Terms,Labels):
		"""
			Decode the Terms list returned by solve4Logic to a logic expression
			Terms : returned by solve4Logic()
			Labels: list of labels of the truth table's column of this variable
					this variable is similar to the one supplying to printTTb
					the variable name with + will be at the right most position
		"""
		exp='{} = '.format(Labels[-1])	# the front part of the expression
		termList=[]
		for t in Terms:					# Iterate through each term and decode
			strTerm=''
			for v in range(len(t)):
				if t[v] == '0':
					strTerm=strTerm+(Labels[v]+"'")
				elif t[v] == '1':
					strTerm=strTerm+(Labels[v])
			termList.append(strTerm)
		return exp + ('+'.join(termList))

"""
	Implement outputs !!!!!
"""
#=====================================MainProgram=============================================
a=MealyStateDiagram('./test2.txt')
# X='11001'
# labels=a.getFullLabels()
# a.printTTb(TTb=a._MainTTb,Labels=None)
# a.printTTb(TTb=a._IntBitTTb[0],Labels=labels[:-1])
# a.printTTb(TTb=a._IntBitTTb[1],Labels=(labels[:-2]+[labels[-1]]))
# term0=a.solve4Logic(TTb=a._IntBitTTb[0])
# term1=a.solve4Logic(TTb=a._IntBitTTb[1])
# print(a.toExpression(Terms=term0,Labels=labels[:-1]))
# print(a.toExpression(Terms=term1,Labels=(labels[:-2]+[labels[-1]])))
labels=a.getFullLabels()
a.printTTb(TTb=a._MainTTb,Labels=None)
a.printTTb(TTb=a._IntBitTTb[0],Labels=labels[:-2])
a.printTTb(TTb=a._IntBitTTb[1],Labels=(labels[:-3]+[labels[-2]]))
a.printTTb(TTb=a._IntBitTTb[2],Labels=(labels[:-3]+[labels[-1]]))
term0=a.solve4Logic(TTb=a._IntBitTTb[0])
term1=a.solve4Logic(TTb=a._IntBitTTb[1])
term2=a.solve4Logic(TTb=a._IntBitTTb[2])
print(a.toExpression(Terms=term0,Labels=labels[:-2]))
print(a.toExpression(Terms=term1,Labels=(labels[:-3]+[labels[-2]])))
print(a.toExpression(Terms=term2,Labels=(labels[:-3]+[labels[-1]])))
