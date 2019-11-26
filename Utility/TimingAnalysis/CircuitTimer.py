# Idea: use list with 2 slots to represent a function
# Slot 0 is the name of the logic function
# Slot 1 is another list holds the parameters of the logic function as strings
# Ex: AND(x1,x2)    => ['AND',['x1','x2']]
#     NOT(x1) => ['NOT',['x1']]
# Each element in the second slot can be another logic function
# Ex: AND(OR(x1,x2),x1) => ['AND',[['OR',['x1','x2']],'x1']
# So the rule for an element in the second slot of the list is
# if it is a string, it is a pure variable
# if it is a list, it is a logic function
# "Pure variable"s are variables defined at the beginning of the description file
# Idea: How to parse the input string described the function?
# Ex: 'function_name=And(XOR(x1,x2)|OR(x1,x2)|'x1')'
# First use '='.split(definition) to separate the function_name(index 0) and the definition(index 1)
# if this is a function, then it begins with a logic function name 
# use rightpart.lstrip(all logic function name), if any of this alter the length
# of the string, that mean this is a beginnign of a logic function
# Remove the logic funtion name, then lstrip('(') rstrip(')')
# Do the same with all variable names to see if the front is a variable
# Do this recursively to create a binary tree
# definition will always enclosed by '(' and ')' 
# Idea: There will be a dictionary called "NameBank" that has
# key(Name of the variable or the function) 
# => value(the value of the variable as strign or the list described the function)
# a function or variable
# A special function named 'VAL' will get the value of the pure variable
# Idea: there are 3 possible logic value '0','1' or 'u'
# 'u' means undefined
import math
import copy

def lstrip(sub,ostr):
    """
        str is the string
        sub is the substring need to be remove at the left
        side of str
        if there is nothing to erase
        return str
        otherwise
        return the str wit sub removed at the beginning
    """
    if len(ostr) < len(sub):
        return ostr
    else:            
        for i in range(len(sub)):
            if ostr[i] != sub[i]:
                return ostr
        # Only reach here if it sub matches the front of str
        return ostr[len(sub):]   # Return str with removed sub

def rstrip(sub,ostr):
    """
        str is the string
        sub is the substring need to be remove at the left
        side of str
        if there is nothing to erase
        return str
        otherwise
        return the str wit sub removed at the beginning
    """
    if len(ostr) < len(sub):
        return ostr
    else:            
        for i in range(len(sub)):
            if ostr[len(ostr)-i-1] != sub[len(sub)-i-1]:
                return ostr
        # Only reach here if it sub matches the front of str
        return ostr[:len(ostr)-len(sub)]   # Return str with removed sub

def gcdList(inp):
    cgcd=math.gcd(inp[0],inp[1])
    for i in inp:
        cgcd=math.gcd(cgcd,i)
    return cgcd

def strD2B(num,width=None):
    biNum=bin(num)
    noPreB=biNum[2:]    # Get rid of prefix 0b
    if width != None:   # Is width specified?
        # Yes
        if len(noPreB) > width: # is the current value longer than width?
            # it is longer, so truncate it
            noPreB=noPreB[len(noPreB)-width:]
        elif len(noPreB) < width: # is the current value shorter than width?
            # it is shorter, so pad it with 0s on the left
            noPreB=((width-len(noPreB))*'0')+noPreB
    return noPreB 

class CircuitTimer:
    def __init__(self,filename):
        # Filed
        self._NameBank={}                       # Dictionary holds all names
        # All logic funcion name, requrie upper case
        self._LogicFunctionName={\
        'AND':self.AND,\
        'NAND':self.NAND,\
        'OR':self.OR,\
        'NOR':self.NOR,\
        'XOR':self.XOR,\
        'NXOR':self.NXOR,\
        'NOT':self.NOT}    
        self._DelayBank={}                      # Dictionary holds delay times of each function
        self._DelayTable={}                     # Dictionary contains the delay for a specific set of input after running timeAnalysis
                                                # All functions are initialized to 0 in delay table after
                                                # running parseNbuildNameBankNDelayBank()
        self._FinalState={}                     # State of each function after time analysis                                                
        self._timeUnit=0                        # The time unit used to simulate, set when run parseNbuildNameBankNDelayBank()
        self._MaxTime=1000                      # Stop time in case there is an non-stop loop
        # Put thing together and solve
        self.parseNbuildNameBankNDelayBank(filename)
        self.buildDelayTimeTable()
        printDelayTable=input('Do you wan to print all delay table?(y/n): ')
        if printDelayTable=='y':
            self.printAllDelayTable()

    def printAllDelayTable(self):
        for i in self._DelayTable.keys():
            self.printDelayTable(i)

    def printDelayTable(self,inp):
        listVar=list(filter(lambda x:isinstance(self._NameBank[x],list),self._NameBank.keys())) # Get list function
        listVar.sort()
        print(inp)
        for f in listVar:
            print('{}={}, '.format(f,self._DelayTable[inp][f]),end='')
        print()

    def buildDelayTimeTable(self):
        listVar=list(filter(lambda x:isinstance(self._NameBank[x],str),self._NameBank.keys())) # Get list variable)
        totalState=2**len(listVar)
        for state in range(totalState):
            currentValue=list(strD2B(state,width=len(listVar)))
            cValues={}
            mask=[]
            for i in range(len(listVar)):
                cValues[listVar[i]]=currentValue[i]
                mask.append(listVar[i]+'='+currentValue[i])
            mask=','.join(mask)
            self._DelayTable[mask]=self.runTimingAnalysis(cValues)

    def runTimingAnalysis(self,cValues={}):
        """
            Run timing analysis with the inital value given
            in cValues
            if cValues={}, the program will get initial value
            from what the user input
        """
        delayTable={}       # This will hold the delay with the current input
        undefinedList={}    # Dictionary all function that currently 
                            # has undefined values (including funciton
                            # that has specific time in the future
                            # where its values will chage but 
                            # currently undefined)
                            # key(functionName) => value(list[value('u' or '1' ' or '0'), time when it])
        # Get initial values
        if len(cValues)==0:
            # if no cValues is given, use the default
            cValues[n]=self._NameBank[n]
        # Initialize the undefinedList
        for n in self._NameBank.keys():
            if isinstance(self._NameBank[n],list):  # Is this a function ?
                # it is a function
                # function has undefined initial value
                cValues[n]='u'
                undefinedList[n]=['u',-1]    # Default value for future time is -1
        # Simulate the circuit
        time=0
        while len(undefinedList)>0 and time <= self._MaxTime:
            # Check if it is the time to change function value
            tmpDict=copy.deepcopy(undefinedList)
            for f in tmpDict.keys():
                listDV=tmpDict[f]
                if listDV[1]!= -1 and listDV[1] <= time:
                    # It is time to change value
                    # Default value is -1 so 
                    # programs only run here if 
                    # there is truly a pending value
                    # on f
                    cValues[f]=listDV[0]
                    # Set the delay time in the delay table
                    delayTable[f]=time
                    # Remove f from undefined list
                    del undefinedList[f]
            if len(undefinedList) == 0: 
                # When there is no more undefiend value
                break
            # If there are still undefined function
            cValuesClone=cValues.copy()
            tmpDict=copy.deepcopy(undefinedList)
            for f in tmpDict.keys():
                newFValue=self.evalFunction(self._NameBank[f],cValuesClone)
                if newFValue != undefinedList[f][0]:    # Does the output of f change or it is still undefined?
                    # New value observed
                    if self._DelayBank[f]==0:
                        # If the function has no delay
                        cValues[f]=newFValue    # Assign value immediately
                        delayTable[f]=time # Record in to the delay table
                        del undefinedList[f]    # Get f off the undefined list
                    else:
                        # If the function has finite delay
                        undefinedList[f]=[newFValue,time+self._DelayBank[f]]
            if len(undefinedList)==0:
                # No more undefined value, then break
                break
            time=time+self._timeUnit        # Increase time
        if time > self._MaxTime:
            print('Maximum simulation time reached')
            return delayTable
        else:
            self._FinalState=copy.deepcopy(cValues)
            return delayTable


    def evalFunction(self,f,imgValues):
        """
            Evaluate function f (in the form of a 2-slot list mentioned above)
            with the given capture
            values of all other functions and pure variables
            in dictionary imgValues
            return the value of f after evaluating
        """
        inpVL=[]
        for i in range(len(f[1])):
            if isinstance(f[1][i],list):    # Is it a logic function or variable?
                # This is a logic function
                inpVL.append(self.evalFunction(f[1][i],imgValues))
            else:
                # It must be an item in imgValues
                inpVL.append(imgValues[f[1][i]])
        return self._LogicFunctionName[f[0]](inpVL) # Get the correct function, evaluate and return

    def parseNbuildNameBankNDelayBank(self,fname):
        f=open(fname,'r')
        # Add pure variable to NameBank
        line=f.readline()
        line=rstrip('}\n',line)              # Get rid of '\n'
        line=lstrip('var_name{',line)
        listPureVar=line.split(',')          # Each element is in form 'var_name=initialvalue'
        for var in listPureVar:
            listVI=var.split('=')            # listVI[0]= var_name, listVI[1]= initial value
            self._NameBank[listVI[0]]=listVI[1]     # Register to the _NameBank
        # Add function name to NameBank
        line=f.readline()
        line=rstrip('}\n',line)              # Get rid of '\n'
        line=lstrip('func_name{',line)
        listFunc=line.split(',')          # Each element is in form 'func_name=initialvalue'
        for func in listFunc:
            self._NameBank[func]='u'     # Register to the _NameBank
        # Parsing and build function
        print(self._NameBank)
        while True:
            line=f.readline()
            if line=='':        # Is end of file yet?
                # Yes, so break
                break
            else:
                # Not yet, so this line is a function definition
                line=rstrip('\n',line)
                listDFNnD=line.split('=')             # left side = delay,function name , right side = definition
                listDF=listDFNnD[0].split(',')        # listDF[0]=delay, list DF[1]=function name
                self._NameBank[listDF[1]]=self.parseFunctionDefinition(listDFNnD[1]) # Parse and register the function into the )NameBank
                print(listDF[1],self._NameBank[listDF[1]])
                self._DelayBank[listDF[1]]=int(listDF[0])
        self._timeUnit=gcdList(list(self._DelayBank.values()))
    
    def parseNextFunction(self,fdef):
        """
            parsing the function definition
            fdef has to start with a logic function
            EX: AND(...
            return a list of two elements
            [[The function length][The function]]
        """
        ParsedResult=[0,[]]     # The result of this function is always a list of two lists
        iLen=oLen=len(fdef)      # iLen will never changes, this is to find the function length
        UpFdef=fdef.upper()
        # try to recognize the function name
        for f in self._LogicFunctionName.keys():
            if len(lstrip(f,UpFdef)) != oLen:     # Does the front have a logic function?
                # Yes
                fdef=fdef[len(f):]            # Get rid of the function name
                fdef=lstrip('(',fdef)
                UpFdef=fdef.upper()
                ParsedResult[0]=f               # Register name of the function
                oLen=len(fdef)
                break
        # Definition now has form 'Parameters)'
        # Parsing parameter
        while len(UpFdef) > 0:
            reloop=False
            if fdef[0]==')':        # is it a ')'?
                fdef=lstrip(')',fdef)   # Get rid of the ')'
                ParsedResult=[iLen-len(fdef),ParsedResult]
                return ParsedResult
            # Is the next parameter a logic function?
            # try to recognize the function name
            for f in self._LogicFunctionName.keys():
                if len(lstrip(f,UpFdef)) != oLen:     # Does the front have a logic function?
                    # Yes
                    # Get the function out of parameter list
                    parseIt=self.parseNextFunction(fdef)
                    ParsedResult[1].append(parseIt[1])
                    fdef=fdef[parseIt[0]:]            # Get rid of the function in the parameter
                    fdef=lstrip(',',fdef)       # Get rid of the comma after the parameter if there is any
                    UpFdef=fdef.upper()
                    oLen=len(fdef)
                    reloop=True
                    break
            if reloop:
                continue
            # Only reach here if next parameter is not a logic function
            # Is it a pure variable name ?
            for f in self._NameBank.keys():
                if len(lstrip(f,fdef))!= oLen:      # Is the front a pure variable with name f?
                    # Yes
                    # Add it to the list then
                    readMore=lstrip(f,fdef)
                    if (readMore[0]!=')') and (readMore[0]!=','): # Is this the full name?
                        # No
                        # Sometime you have variable names like fun and fun11
                        # if f = fun but the expression actually has fun11
                        # this funciton still matches
                        # But notice, after a parameter is either ')' or ','
                        # if f did not cover all parameter name
                        # the first character after lstrip(f) is not ')' nor ','
                        continue
                    ParsedResult[1].append(f)
                    fdef=fdef[len(f):]            # Get rid of the variable in the parameter
                    fdef=lstrip(',',fdef)       # Get rid of the comma after the parameter if there is any
                    UpFdef=fdef.upper()
                    oLen=len(fdef)
                    reloop=True
                    break
            if reloop:
                continue
            # It it is here, that means it is not var name
            # nor logic funtion name
            # nor ')'
            # Then there must be a syntax error
            # Then there is syntax error
            raise ValueError("Syntax error, unbalanced () or undefined pure variable")


    def parseFunctionDefinition(self,fdef):
        """
            parsing the function definition
            fdef has to start with a logic function
            EX: AND(...
        """
        parsedFunction=self.parseNextFunction(fdef)
        return parsedFunction[1]

    def OR(self,inp):
        """
            Evaluating function OR
            inp is a list of string of '0' ,'1' or 'u' 
        """
        result='0'
        for i in inp:
            if i=='1':
                # Only needs 1 '1' to return '1'
                return '1'
            elif i=='u':
                # 1 'u' makes the result potentially 'u'
                # but still needs to continue to see if
                # there is any '1' later in the list
                result='u'
        return result

    def NOR(self,inp):
        """
            Evaluating function NOR
            inp is a list of string of '0' ,'1' or 'u' 
        """
        result=self.OR(inp)
        if result=='1':
            return '0'
        elif result=='0':
            return '1'
        else:
            return 'u'

    def AND(self,inp):
        """
            Evaluating function AND
            inp is a list of string of '0' ,'1' or 'u' 
        """
        result='1'
        for i in inp:
            if i=='0':
                # Only needs 1 '0' to return '0'
                return '0'
            elif i=='u':
                # 1 'u' makes the result potentially 'u'
                # but still needs to continue to see if
                # there is any '1' later in the list
                result='u'
        return result

    def NAND(self,inp):
        """
            Evaluating function NAND
            inp is a list of string of '0' ,'1' or 'u' 
        """
        result=self.AND(inp)
        if result=='1':
            return '0'
        elif result=='0':
            return '1'
        else:
            return 'u'

    def XOR(self,inp):
        """
            Evaluating function XOR
            inp is a list of string of '0' ,'1' or 'u' 
        """
        odd=False
        for i in inp:
            if i=='u':
                # Only needs 1 'u' to return 'u'
                return 'u'
            elif i=='1':
                odd=not odd
        if odd:
            return '1'
        else:
            return '0'
        return result        

    def NXOR(self,inp):
        result=self.XOR(inp)
        if result=='1':
            return '0'
        elif result=='0':
            return '1'
        else:
            return 'u'

    def NOT(self,inp):
        """
            inp is a 1-character string : '0','1',or 'u'
        """
        if inp[0]=='0':
            return '1'
        elif inp[0]=='1':
            return '0'
        else:
            return 'u'

#=============Test==============
#a=CircuitTimer('./Test1.txt')
#a=CircuitTimer('./Test2')
#a=CircuitTimer('./Test3.txt')
#a=CircuitTimer('./Test4.txt')