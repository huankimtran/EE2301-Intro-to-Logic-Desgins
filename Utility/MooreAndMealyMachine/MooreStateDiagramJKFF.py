import math
from functions import *
DEBUG=False
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
class MooreStateDiagram:				
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
  def __init__(self,fileName,printSolved=True):
      """
        Initialized an object
        if printSolved=True => solve the state diagram and print out expression
        else printSolved=False => solve the state diagram but don't print out anythng
      """
      self._OutPrefix='Z'					# The prefix of output bits (Z0,Z1,..)
      self._InpPrefix='X'					# The prefix of input bits (X0,X1,..)
      self._IntBitPrefix='D'				# The prefix of internal bits (D0,D1,D2...) 
      self._JKPrefix='JK'					# Prefix for output JK
      self._mType="NotSet"
      self._numState=0					# Number of State
      self._numInp=0						# Number of inputs
      self._numOut=0						# Number of outputs
      self._numIntBit=0					# Number of internal bit to represent state
      self._StateBank={}					# The collection of state object
      self._StateOutputBank={}				# A dictionary of the output of each state (key(stateIndex)=>value(output of the state))
      self._IntBitTTb=[]					# The collection of internal bit next state truth table
      self._OutBitTTb=[]					# The collection of otuput bit truth table
      self._JKBitTTb=[]
      self._MainTTb={}					# The main truth table where left side are current state
                        # and right side are next state of each bit and the ouput bits
                        # Ex: D0|D1|X0|X1|D0+|D1+|Z0|Z1
                        # 	<<=Left Side=|===Right Side=>
      self._SolvedExpr={}					# A dictionary of logic expression of each internal bit and output bit 
                        # encoded using the format returned by execute in funtions module
                        # aka BitName:['--01','0-11'] <=> BitName=c'd+a'cd
      self._TestInp=[]						# Test input
      self._TestOut=[]						# Test output
      self.parseNBuildStateBank(fileName)	# Build the StateBank, _TestInp and _TestOut needs to be initilized above this
      if len(self._TestInp)>0:			# Is there test to test the diagram?
        # Test it
        if self.verifyDiagram():
          print('State Diagram is Correct!')
        else:
          print('WRONG state Diagram')
          return
      # Only countinue to solve if the diagram is correct
      # Program won't reach here if it failed the test case
      self.buildMainTTb()					# Build the main truth table for all bit
      self.buildIntBitTTb()				# Built the truth table for each internal bit
      self.buildOutBitTTb()				# Built the truth table for each output bit
      
      self.buildJKBitTTb()        # Build the truth table for JK

      self.solve2buildSolvedExpre()		# Solve the State Diagram to find expression
      
      self.solveJKFF()
      
      if printSolved:						# Print the solution if asked
        self.printSolution(self._SolvedExpr)


  def verifyDiagram(self):
    inpSequene=[]
    # Build input sequence
    for time in range(len(self._TestInp[0])):
      inpSequene.append('')
      for inp in range(len(self._TestInp)):
        inpSequene[time]+=self._TestInp[inp][time]
    outSequence=self._numOut*['']
    # Always starts at state 0
    cState=0
    for t in range(len(inpSequene)):							# Ignore the last output bit
      cOutput=self._StateOutputBank[cState]					# Obtaining the current output
      cState=self._StateBank[cState][inpSequene[t]]			# Obtain the next state
      # Accumulate the outputs to the  corrent output string
      for i in range(len(cOutput)):
        outSequence[i]+=cOutput[i]		 
    # Match the generated sequence with given one and check if any difference
    print('Output sequence using given state diagram :')
    print(outSequence)
    print('Corrent output sequence :')
    print()
    print(self._TestOut)
    if len(list(filter(lambda x:not x,list(map(lambda a,b:a==b,outSequence,self._TestOut))
)))==0:
      return True
    else:
      return False

    # Ignore the first value of the outputt test
    # since you can not be sure about the first state output
    

  def solve2buildSolvedExpre(self):
    """
      Solve the state diagram to find 
      logic expression for each internal bit and output bit
    """
    var2beSolved=(lambda x:x[self.getBLI4P(None):])(self.getFullLabels())
    for var in var2beSolved:
      if var[0]==self._IntBitPrefix:
        # This is an internal bit
        self._SolvedExpr[var]=self.solve4Logic(TTb=self._IntBitTTb[int(var[1:-1])])
      else:
        # This is an output bit
        self._SolvedExpr[var]=self.solve4Logic(TTb=self._OutBitTTb[int(var[1:])],outputSolve=True)

  def printSolution(self,Solution):
    # Print the main truth table
    print('Main truth table')
    self.printTTb(TTb=self._MainTTb,Labels=None)
    print('Truth table of each variable and its expression')
    varSolved=list(self._SolvedExpr.keys())
    varSolved.sort()	# Make them printed out in ascending order
    for var in varSolved:
      if var[0] == self._IntBitPrefix:
        # Do not print out the internal bit
        # Since this is JK implementation
        # No need to find expression for DFF
        pass
      elif var[0] in self._JKPrefix:
        # This is a J or K output
        print('Variable {} :'.format(var))
        tmpLabels=self.getBEL(int(var[1:-1]),outputBit=False)
        # Since the last element in tmpLabels will be internal bit D0 D1,.. something like that
        # Take that internal bit out and replace by the JK label
        tmpLabels.pop()
        tmpLabels.append(var)
        if DEBUG:
          print('tmpLables_195',tmpLabels)
          print('JKTTB',self._JKBitTTb[int(var[1:-1])][var[0]])
        print(self.toExpression(Terms=self._SolvedExpr[var],Labels=tmpLabels))
        self.printTTb(TTb=self._JKBitTTb[int(var[1:-1])][var[0]],Labels=tmpLabels)
        print('\n\n')

        # This is old code for printing an internal bit
        # print('Variable {} :'.format(var))
        # print(self.toExpression(Terms=self._SolvedExpr[var],Labels=self.getBEL(int(var[1:-1]),outputBit=False)))
        # self.printTTb(TTb=self._IntBitTTb[int(var[1:-1])],Labels=self.getBEL(int(var[1:-1]),outputBit=False))
        # print('\n\n')
      else:
        # This is an output bit
        print('Variable {} :'.format(var))
        print(self.toExpression(Terms=self._SolvedExpr[var],Labels=self.getBEL(int(var[1:]),outputBit=True)))
        self.printTTb(TTb=self._OutBitTTb[int(var[1:])],Labels=self.getBEL(int(var[1:]),outputBit=True))
        print('\n\n')

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
        i=i+1
        # Reach the test input and output sequence part yet?
        if(i > self._numState):
          # Yes, then get out of the loop to parse the test input output
          break
        parsedState=line.split(',')		# Moore have statei index, output				
        stateIndex=int(parsedState[0])
        self._StateBank[stateIndex]={}
        self._StateOutputBank[stateIndex]=parsedState[1]	# Each state has at least a key named "OUT" to save output value of the state
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
          if j in self._StateBank[stateIndex].keys():	# Is this input sequence already added?
            # Already added, so spit out error
            print('Duplicated input sequence: State {}, next state {}, {} input sequence duplicated'.format(stateIndex,nextStateIndex,InpCommaOut[0]))
            raise ValueError('Error building main truth table')
          else:
            self._StateBank[stateIndex][j]=nextStateIndex	# Moore does not need next state output since each state has one output
                                      # -1 indicate no use
          totalLink+=1
    # When the loop exit, the file cursor is at the test input
    # So back up
    f.seek(pos)
    if len(parsedLine)!=0:		# Is there any tests ?
      # Yes, so initialize the containers and get them
      self._TestInp=self._numInp*['']		# Test input
      self._TestOut=self._numOut*['']		# Test output
      # Get input test
      for ti in range(self._numInp):
        line=f.readline()
        self._TestInp[ti]=line[:-1]	# line[:-1] to get rid of the \n
      # Get output test
      for to in range(self._numInp):
        line=f.readline()
        self._TestOut[to]=line[:-1]	# line[:-1] to get rid of the \n
    if DEBUG:
      print("State Bank",self._StateBank)
      print("Output Bank",self._StateOutputBank)

# ======================Additional function to solve for JK=====================
  def solveJKFF(self):
    for i in range(self._numIntBit):
      if DEBUG:
        print("_JKBitTTB[i]['J']_107",self._JKBitTTb[i]['J'])
      
      self._SolvedExpr['J'+str(i)+'+']=self.solve4Logic(TTb=self._JKBitTTb[i]['J'])
      self._SolvedExpr['K'+str(i)+'+']=self.solve4Logic(TTb=self._JKBitTTb[i]['K'])

      if DEBUG:
        print("self._SolvedExpr[K+]",self._SolvedExpr['K'+str(i)+'+'])

  def nextJK(self,cI,nI):
    if cI=='0' and nI=='0':
      return {'J':'0','K':'x'}
    elif cI=='0' and nI=='1':
      return {'J':'1','K':'x'}
    elif cI=='1' and nI=='0':
      return {'J':'x','K':'1'}
    elif cI=='1' and nI=='1':
      return {'J':'x','K':'0'}
    else:
      return {'J':'x','K':'x'}

  def buildJKBitTTb(self):
    for i in range(self._numIntBit):
      self._JKBitTTb.append({'J':{},'K':{}})
      for inp in self._IntBitTTb[i].keys():
        # J K output is also a function of inputbit and internal bit
        # so no need to strip out the internal bit in inp variable
        vl=self.nextJK(inp[i],self._IntBitTTb[i][inp])
        self._JKBitTTb[i]['J'][inp]=vl['J']
        self._JKBitTTb[i]['K'][inp]=vl['K']
#====================Original MooreStateDiagram class function
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
      
      # Building the left side of the truth table
      internalBit=strD2B(state,width=self._numIntBit)	#Bit0Bit1..BitN
      if state in self._StateBank.keys():	# Is this a defined state?
        # Yes
        # Getting the Input0Input1...InputN bitstring
        inpBitList=list(self._StateBank[state].keys())
        inpBitList.sort()		# Make it looks organized
        for inp in inpBitList:		#Loop through each
          leftSideTruthTTb=internalBit+inp 			# Building the left side
          # Build the right side which is D0+|D1+|....|Z0|Z1|... (next internal bits states + output bits states)
          IntBitNextValues=strD2B(self._StateBank[state][inp],width=self._numIntBit)	# Next inp next state
          OutBitNextValues=self._StateOutputBank[state]				# Corresponding output bits
          # Combine next internal bits and output bits to form right side
          self._MainTTb[leftSideTruthTTb]=IntBitNextValues + OutBitNextValues
      else:
        # No this is not a defined state, will be assign don't care
        inpBitList=[strD2B(x,width=self._numInp) for x in range(2**self._numInp)]
        for inp in inpBitList:		#Loop through each
          # Build left side
          leftSideTruthTTb=internalBit+inp
          # Build right side don't care for next bit and output bit 
          self._MainTTb[leftSideTruthTTb]=(self._numIntBit + self._numOut)*'x'

  def buildIntBitTTb(self):
    """ build the truth table for each bit
      _IntBitTTb[bit0,bit1,bit2..]
      _IntBitTTb[bitN]=Dictionary(key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(bitN+ = '0' or '1' or' x'))
    """
    self._IntBitTTb=[{} for i in range(self._numIntBit)]	# Make an empty dictionary for each bit
    leftSide=list(self._MainTTb.keys())						# Get all possible input
    leftSide.sort()					# Make input ascending order (0..0 ,0..1 ,.0..10,..)
    for b in range(self._numIntBit):			# Loop through each internal bit and build truth table for such bit
      for inp in leftSide:
        self._IntBitTTb[b][inp]=self._MainTTb[inp][b]	#Getting the right side corresponding row of the main truth table and extract the bit out

  def buildOutBitTTb(self):
    """ build the truth table for each bit
      _OutBitTTb[bit0,bit1,bit2..]
      _OutBitTTb[bitN]=Dictionary(key(bitstring(Bit0Bit1..BitNInputt0Input1..InputN)=>value(output bitZ = '0' or '1' or' x'))
    """
    self._OutBitTTb=[{} for i in range(self._numOut)]	# Make an empty dictionary for each bit
    leftSide=list(self._MainTTb.keys())						# Get all possible input
    leftSide.sort()					# Make input ascending order (0..0 ,0..1 ,.0..10,..)
    for b in range(self._numOut):			# Loop through each internal bit and build truth table for such bit
      for inp in leftSide:
        # Getting the right side corresponding row of the main truth table and extract the bit out
        # The index of the output bit
        # in the result value of the _MainTTb dictionary
        # starts from self._numIntBit 
        # Moore machine output does not depends on input value so
        # the input bits in inp needs to be removed
        outpCo=inp[:len(inp)-self._numInp]
        self._OutBitTTb[b][outpCo]=self._MainTTb[inp][self._numIntBit + b]	

  def getFullLabels(self,nextState=None):
    """
      Make and return the full lables of each column in _MainTTb
      if nextState = None =>> right side will be internal bits + output bits 
      nextState= False => right side will be output
      else => right side will be next internal bit
    """
    leftLables=[self._IntBitPrefix+str(i) for i in range(self._numIntBit)] + [self._InpPrefix+str(i) for i in range(self._numInp)]
    if nextState == None:
      rightLabels=[self._IntBitPrefix+str(i)+'+' for i in range(self._numIntBit)]	# Internal bits
      rightLabels+=[self._OutPrefix+str(i) for i in range(self._numOut)] 			# Output bits
    elif nextState:
      # nextState= True => only next internal bit
      rightLabels=[self._IntBitPrefix+str(i)+'+' for i in range(self._numIntBit)]
    else:
      # nextState is False or something else => OuputBit
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
      Labels=self.getFullLabels(Labels)
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

  def solve4Logic(self,TTb,outputSolve=False):
    """
      Using the provided library that implement Quine-McCluskey Method
      to solve for logic expression
      TTb is a truth table with left side is all input and right side is
      ONLY ONE variable of which expression will be solved for (aka: something similar to 
      an element of the _IntBitTTb)
      return a list[]=['01-1...','01-1...',...]
    """
    if outputSolve:
      size=self._numIntBit
    else:
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
    else:
      # No, you need to take of the '\n' in function[1]
      function[1]=function[1][:-1]
    if DEBUG:
      print(function)
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
    if len(Terms)==1 and Terms[0]=='----':
      # When truth table is 1 or don't care for all entries
      return exp+'1'
    for t in Terms:					# Iterate through each term and decode
      strTerm=''
      for v in range(len(t)):
        if t[v] == '0':
          strTerm=strTerm+(Labels[v]+"'")
        elif t[v] == '1':
          strTerm=strTerm+(Labels[v])
      termList.append(strTerm)
    return exp + ('+'.join(termList))

  def getBitLabelIndex(self,bitN=None,outputBit=False):
    """
      Return the next internal bit label 
      or the output bit label 
      index in the full labels return by getFullLabels(None)
      (Aka: one of the label on the right side) which is also column index in _MainTTb
      Ex: D0|D1|X0|X1|D0+|D1+|Z0|Z1
      <<===Left Side=|===Right Side=>
      getBitLabel(bitN=0,outputBit=False) => D0+
      getBitLabel(bitN=1,outputBit=False) => D1+
      getBitLabel(bitN=0,outputBit=True) =>  Z0
      ......
      If outputBit=False => return the label of the next internal bit with index bitN (D0+,D1+...)
      outputBit=True =>  return the label of the next output bit with index bitN (Z0,Z1...)
    """
    if bitN == None:
      return self._numIntBit + self._numInp-1
    if outputBit:
      # outputBit = True
      return self._numIntBit + self._numInp + self._numIntBit + bitN
    else:
      # outputBit = False
      return self._numIntBit + self._numInp + bitN

  def getBLI4P(self,bitN=None,outputBit=False):
    """
      getBitLabelIndex4Print
    """
    return self.getBitLabelIndex(bitN,outputBit)+1

  def getBitLabel(self,bitN,outputBit=False):
    """
      Similar to getBitLabelIndex but return the label itself
    """
    labels=self.getFullLabels(None)
    if outputBit:
      # outputBit = True
      return labels[self._numIntBit + self._numInp + self._numIntBit + bitN]
    else:
      # outputBit = False
      return labels[self._numIntBit + self._numInp + bitN]

  def getBEL(self,bitN=None,outputBit=False):
    """
      getBitEpxressionLabel
    """
    labels=self.getFullLabels()
    if outputBit:
      # Moore state output truth table does not have inputs
      return labels[:self.getBLI4P(None)-self._numInp] + [self.getBitLabel(bitN,outputBit)]
    else:
      return labels[:self.getBLI4P(None)] + [self.getBitLabel(bitN,outputBit)]

#=====================================MainProgram=============================================
# This is only to test this module, use main.py to run the correct diagram
a=MooreStateDiagram('./MoTest4.txt')

# labels=a.getFullLabels()
# a.printTTb(TTb=a._MainTTb,Labels=None)
# a.printTTb(TTb=a._IntBitTTb[0],Labels=a.getBEL(0,outputBit=False))
# a.printTTb(TTb=a._OutBitTTb[0],Labels=a.getBEL(0,outputBit=True))
# term0=a.solve4Logic(TTb=a._IntBitTTb[0])
# term1=a.solve4Logic(TTb=a._OutBitTTb[0])
# print(a.toExpression(Terms=term0,Labels=a.getBEL(0,outputBit=False)))
# print(a.toExpression(Terms=term1,Labels=a.getBEL(0,outputBit=True)))