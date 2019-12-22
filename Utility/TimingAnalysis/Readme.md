# Logic circuit timing analysis utility
* Create arrival time table for a given logic circuit
* Allow multi function definitions
* Allow defining logic function in term of other functions
Read the Circuit Description to know how to describe the logic circuit to the computer <br/>
An example how to create a description file given below <br/>
<br/>

![Image description](./ReadMeImg/Test3-4.png)

<br/>
```
var_name{x1=1,x2=1,x3=1,x4=1}<br/>
func_name{f1,f2,f3,f4,f5,f6,f7,f8}<br/>
1,f1=NOR(x1,f8)<br/>
1,f2=NAND(x2,f1)<br/>
1,f3=NAND(x3,f2)<br/>
1,f4=NOR(f3,x4)<br/>
1,f5=OR(x1,f4)<br/>
1,f6=OR(x2,f5)<br/>
1,f7=AND(x3,f6)<br/>
1,f8=AND(f7,x4)<br/>
