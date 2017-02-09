format short
t=[0,1,2,3,4,5,6,7];
f=[8.2,4,1.9,1,0.56,0.2,0.11,0.026];
baza0=[1,1,1,1,1,1,1,1];
baza1=t;
baza0
baza1
lnf=log(f);
A=[baza0*baza0' baza1*baza0'
   baza0*baza1' baza1*baza1']
d=[lnf*baza0'
   lnf*baza1']
koef=A\d
a=exp(koef(1));
b=koef(2);
x=linspace(0,7,1000);
y=a*exp(b*x)
plot(t,f,x,y)