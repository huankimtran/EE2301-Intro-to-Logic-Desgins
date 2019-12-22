def Num2Let(num):
    return chr(97+num)
def Let2Num(let):
    return ord(let)-97
def evalExs(vl,expr):
    for i in range(len(vl)-1):
        exec('{}={}'.format(Num2Let(i),vl[i]))
    return int(eval(expr))
n=int(input('Number of variable:'))
truthTable=[]
xnf=''
for i in range(n):
    print('{} '.format(Num2Let(i)),end='')
print('F')
for i in range(2**n):
    bi=format(i,'0'+str(n)+'b')
    sep=list(bi)
    to10=tuple(map(lambda x:int(x),sep))
    for j in range(n):
        print('{} '.format(to10[j]),end='')
    truthTable.append(to10+(int(input('value=')),))
    if i==0:
        xnf=xnf+str(truthTable[i][-1])
    else:
        if evalExs(truthTable[i],xnf) != truthTable[i][-1]:
            xnf=xnf+'^'
            for j in range(n):
                if truthTable[i][j]==1:
                    xnf=xnf+Num2Let(j)+'&'
            if xnf[-1]=='&':
                xnf=xnf[:len(xnf)-1]
#Print out using python logic notation
print(xnf)
print()
print()
#Print out using notation of site
#http://turner.faculty.swau.edu/mathematics/materialslibrary/truth/
#So that user can copy paste and double check
print(xnf.replace('^','#'))
#write the notation out to file in case user cannot copy from the terminal window
a=open('TruthTable2XNF.txt','w')
a.write(xnf.replace('^','#'))
a.close()
