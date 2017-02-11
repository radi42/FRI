clc;
clear all;
amplitudaPre1 = 3;
amplitudaPre0 = 0;
pocet=15;
bitoveSlovo=zeros(1,pocet); %vytvorenie slova plneho nul
for i = 1:pocet             %naplnenie bitoveho slova nahodnymi znakmi{0,1}
   pom=randi(2);
   bitoveSlovo(i)= mod(pom,2);
end;
vyslednySignal=zeros(pocet,100);%vytvorenie pola signalu plneho nul
for k = 1:pocet             % cyklus vytvara dany poèet signalovych zmien 
fs = 11025;
t=linspace(k*2*pi,(k*2+2)*pi,100);
c=bitoveSlovo(k);
if c==1                     % if urèujuci èo sa spraví s 1 a 0
    signal=amplitudaPre1*sin(t+k*2*pi);
else
    signal=amplitudaPre0*sin(t+k*2*pi);
end
vyslednySignal(k,1:100)=signal;
end; 
sucet=zeros(1,100*pocet);   
for i = 1:pocet             %cyklus preloží signal z dvojrozmerneho pola na jednorozmerne
    for j = 1:100
        sucet(1,i*100-100+j) = vyslednySignal(i,j);
    end;
end;

% teraz vypisovanie signalu a vodiacich èiar

t2=linspace(1,100*pocet,pocet+1);
for k = 1:pocet 
    plot(t2,k/1000,'r');
    hold on
    plot(t2,-k/1000,'r');
    hold on
end;
t=linspace(1,100*pocet,1000*pocet);
plot(t,0,'black');
hold on
plot(sucet);
hold on
sound(sucet,fs,16);

%zapisanie signalu do zvukoveho suboru
wavwrite(sucet,fs,'E:\amplituda.wav');
