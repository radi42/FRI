
infoStano=audioinfo('C:\novy\stano.mp3');
[Stano,fsStano]=audioread('C:\novy\stano.mp3');
infoIko=audioinfo('C:\novy\iko.mp3');
[Iko,fsIko]=audioread('C:\novy\iko.mp3');
infoKubo=audioinfo('C:\novy\kubo.mp3');
[Kubo,fsKubo]=audioread('C:\novy\kubo.mp3');
pom=size(Iko);
PocetIko=pom(1);
pom=size(Stano);
PocetStano=pom(1);
pom=size(Kubo);
PocetKubo=pom(1);
disp(infoIko);
disp(infoStano);
disp(infoKubo);
vysledok=zeros(1,PocetKubo);


vyslednySignalKubo=zeros(PocetKubo,100);
vyslednySignalStano=zeros(PocetKubo,100);
vyslednySignalIko=zeros(PocetKubo,100);
for k = 1:PocetKubo
fs = 44100;
t=linspace(k*2*pi,(k*2+2)*pi,100);
signal=sin(1*(t+k*2*pi));
vyslednySignalKubo(k,1:100)=signal;
signal=sin(4*(t+k*2*pi));
vyslednySignalStano(k,1:100)=signal;
signal=sin(8*(t+k*2*pi));
vyslednySignalIko(k,1:100)=signal;
end; 
sucetKubo=zeros(1,PocetKubo*100);
sucetStano=zeros(1,PocetStano*100);
sucetIko=zeros(1,PocetIko*100);
for i = 1:PocetKubo
    for j = 1:100
        sucetIko(1,i*100-100+j) = vyslednySignalIko(i,j);
        sucetKubo(1,i*100-100+j) = vyslednySignalKubo(i,j);
        sucetStano(1,i*100-100+j) = vyslednySignalStano(i,j);
    end;
end;
for i=1:PocetKubo
    Iko(i)=Iko(i)*sucetIko(1,i);
    Stano(i)=Stano(i)*sucetStano(1,i);
    Kubo(i)=Kubo(i)*sucetKubo(1,i);
    vysledok(1,i)=Iko(i)+Stano(i)+Kubo(i);
end;
%plot(Kubo);
%hold on
%plot(Stano,'r');
%hold on
%plot(Iko,'g');
%plot(vysledok);
%plot(nosnyKubo);
%sound(Kubo,fsIko);
%pause(3);
%sound(Iko,fsIko);
%pause(3);
%sound(Stano,fsIko);
%pause(3);
sound(vysledok,fsIko);