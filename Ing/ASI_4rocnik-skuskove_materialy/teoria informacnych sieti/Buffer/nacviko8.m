clear
format short

% parametre Binomickeho rozdelenia
p = 0.5;
n = 2;

c = 1;          %pocet spracovanych dat 
max=2000;       %pocet generovanych dat
maxPlot=500;    %max pocet vykreslenych dat
minPlot=1;      %zaciatok vykreslenych dat
maxBuffer=4;
A=0;
B=0;


arrayA=zeros(1,max);
arrayA=binornd(n,p,[1,max]);
arrayB=zeros(1,max);
Buffer=0;
arrayG=zeros(1,max);


for i=1:max
    Buffer=Buffer+arrayA(i);
 %Obmedzenie Buffra  

        if Buffer > (maxBuffer+1)
            Buffer=maxBuffer+1;
        end

    if Buffer >0
        Buffer=Buffer-c;
        arrayB(i)=c;
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
histogram(arrayG);
%}

%pohlad na tok

subplot(3,1,1)
plot(t(minPlot:maxPlot),arrayA(minPlot:maxPlot),0,3)
title('vstupny tok')
subplot(3,1,2)
plot(t(minPlot:maxPlot),arrayG(minPlot:maxPlot),0,5)
title('Buffer')
subplot(3,1,3)
plot(t(minPlot:maxPlot),arrayB(minPlot:maxPlot),0,2)
title('vystupny tok')

