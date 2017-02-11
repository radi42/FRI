clear
format short

% parametre Binomickeho rozdelenia
p = 0.05;
n = 1;
nB = 1;
pB = 0.08;

c = 1;          %pocet spracovanych dat 
max=20000;       %pocet generovanych dat
maxPlot=1000;    %max pocet vykreslenych dat
minPlot=1;      %zaciatok vykreslenych dat
maxBuffer=6;
arrayBuffer=binornd(nB,pB,[1,max]);

A=0;
B=0;


arrayA=zeros(1,max);
arrayA=binornd(n,p,[1,max]);
arrayB=zeros(1,max);
Buffer=0;
arrayG=zeros(1,max);


for i=1:max
    Buffer=Buffer+arrayA(i);
   
        if Buffer > (maxBuffer+1)
            Buffer=maxBuffer+1;
        end
 
    if Buffer >= arrayBuffer(i)
        Buffer=Buffer-arrayBuffer(i);
        arrayB(i)=arrayBuffer(i);
        arrayG(i)=Buffer;
    else
        arrayB(i)=Buffer;
        Buffer = 0;
        arrayG(i)=Buffer;
    end
    
  end


A=cumsum(arrayA);
B=cumsum(arrayB);

t=linspace(1,max,max);
%tieto veci chcel Smiesko

%{
subplot(2,1,1)
plot(t(minPlot:maxPlot),A(minPlot:maxPlot))
hold on
plot(t(minPlot:maxPlot),B(minPlot:maxPlot))
subplot(2,1,2)
hist(arrayG);
%}

%pohlad na tok

subplot(5,1,1)
plot(t(minPlot:maxPlot),arrayA(minPlot:maxPlot),0,2)
title('vstup')
subplot(5,1,2)
plot(t(minPlot:maxPlot),arrayG(minPlot:maxPlot),0,5)
title('buffer')
subplot(5,1,3)
plot(t(minPlot:maxPlot),arrayB(minPlot:maxPlot),0,2)
title('vystup')
subplot(5,1,4)
hist(arrayG)
title('histogram buffera')
subplot(5,1,5)
plot(t(minPlot:maxPlot),arrayBuffer(minPlot:maxPlot))
title('C')