function LB = zadanie_bran(Pp,Pv,maxBuffer,iteracie)
format short

% parametre Binomickeho rozdelenia
%Pp = 0.05;
n = 1;
nB = 2;
%Pv = 0.08;

%iteracie=2000;       %pocet generovanych dat
maxPlot=iteracie;    %max pocet vykreslenych dat
minPlot=1;      %zaciatok vykreslenych dat
%iteracieBuffer=7;
arrayBuffer=binornd(nB,Pv,[1,iteracie]); %rozhodnutie o opusteni paketu

arrayA=zeros(1,iteracie);
arrayA=binornd(n,Pp,[1,iteracie]); %prichod paketov
arrayB=zeros(1,iteracie);
Buffer=0;
arrayG=zeros(1,iteracie);


for i=1:iteracie
    Buffer=Buffer+arrayA(i);
   
        if Buffer > (maxBuffer)
            Buffer=maxBuffer;
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
t=linspace(1,iteracie,iteracie);

subplot(5,1,1)
plot(t(minPlot:maxPlot),arrayA(minPlot:maxPlot),0,2)
title('Prichod paketov')
subplot(5,1,2)
plot(t(minPlot:maxPlot),arrayG(minPlot:maxPlot),0,5)
title('Buffer')
subplot(5,1,3)
plot(t(minPlot:maxPlot),arrayB(minPlot:maxPlot),0,2)
title('Vystup paketov')
subplot(5,1,4)
hist(arrayG)
title('Histogram')
subplot(5,1,5)
plot(t(minPlot:maxPlot),arrayBuffer(minPlot:maxPlot))
title('Mozny vystup')
end

