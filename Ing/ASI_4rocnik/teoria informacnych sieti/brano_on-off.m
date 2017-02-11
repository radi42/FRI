clear
format short

fileID = fopen('E:\6meranie4050.txt','r');
formatSpec = '%d';
a = fscanf(fileID,formatSpec);
arrayD=a';
max=2000;
alfa=0.80;%cim mensia tym viac 1
beta=0.80;%cim mensia tym viac 0
gama=0.50;%rozdelenie bernuliho

maxPlot=200;
skalovanie  = 20;
max2=max/skalovanie;
arrayD2= zeros(1,max2);
k=1;
max3=2000000;
arrayB=zeros(1,max);
arrayB=binornd(1,gama,[1,max3]);
arrayB2= zeros(1,max3/skalovanie);
arrayB3= zeros(1,skalovanie+1);
arrayD3= zeros(1,skalovanie+1);

%bernuliho rozdelenie
k=1;
for i=1:max3
    
   arrayB2(k)=arrayB2(k)+arrayB(i);
  if mod(i,skalovanie)==0
     k=k+1;
 end
    
   
end

l=0;
h=0;
for i=1:(max3/skalovanie)
l=arrayB2(i)+1;

h=arrayB3(l);
h=h+1;
arrayB3(l)=h;

end

for i=1:(skalovanie+1)
h=arrayB3(i);
h=h/(max3/max);
arrayB3(i)=h;
end


t=linspace(0,skalovanie,skalovanie);


%{

%vlastny Berunuli
k=1;
arrayA(1)=1;
arrayA3= zeros(1,skalovanie+1);
arrayA2= zeros(1,max3/skalovanie);
for i=2:max3
 r1=rand;
 if r1<gama 
    arrayA(i)=1;
 else arrayA(i)=0;
 end
end
k=1;
for i=1:max3
    
   arrayA2(k)=arrayA2(k)+arrayA(i);
  if mod(i,skalovanie)==0
     k=k+1;
 end
    
   
end

l=0;
h=0;
for i=1:(max3/skalovanie)
l=arrayA2(i)+1;

h=arrayA3(l);
h=h+1;
arrayA3(l)=h;

end

for i=1:(skalovanie+1)
h=arrayA3(i);
h=h/(max3/max);
arrayA3(i)=h;
end


%}
%vstupny subor 
k=1;
for i=1:max
    
    arrayD2(k)=arrayD2(k)+arrayD(i);
    if mod(i,skalovanie)==0
        k=k+1;
    end
    
   
end

for i=1:max2
l=arrayD2(i)+1;

h=arrayD3(l);
h=h+1;
arrayD3(l)=h;

end
%ON/OFF

a(1)=1;
prav(1)=1;
suma=0;


for i=2:max3
    r1=rand;
     if a(i-1)==1
       if r1<(1-alfa)
           a(i)=1;
       else
           a(i)=0;
       end
    else 
        if r1<(1-beta)
           a(i)=0;
       else
           a(i)=1;
       
       end
     end
    
  end
t2=linspace(1,max,max);

arrayO=a';
arrayO2= zeros(1,max3/skalovanie);
arrayO3= zeros(1,skalovanie+1);

%ON/OFF
k=1;
for i=1:max3
    
   arrayO2(k)=arrayO2(k)+arrayO(i);
  if mod(i,skalovanie)==0
     k=k+1;
 end
    
   
end

l=0;
h=0;
for i=1:max3/skalovanie
l=arrayO2(i)+1;

h=arrayO3(l);
h=h+1;
arrayO3(l)=h;

end

for i=1:(skalovanie+1)
h=arrayO3(i);
h=h/(max3/max);
arrayO3(i)=h;
end


%histogram

subplot(3,1,1)
plot(t2(1:300),arrayD(1:300),0,2)
title('tok suboru')
subplot(3,1,2)
plot(t,arrayD3(1:skalovanie))
title('histogram toku, bernuliho rozdelenie, on/off ,slot =4')
hold on
plot(t,arrayB3(1:skalovanie))
hold on 
plot(t,arrayO3(1:skalovanie))
%hold on
%plot (t,arrayA3(1:skalovanie))
subplot(3,1,3)

histogram(arrayD2)
title('histogram toku, histogram on/off')
hold on
histogram(arrayO2(1:200))


