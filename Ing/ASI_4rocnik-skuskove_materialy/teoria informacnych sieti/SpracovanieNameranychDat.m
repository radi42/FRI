clc
clear all
%close all
format short

% load data
data = load('E:/6meranie4050.txt');
[~,count] = size(data);

% slot data & additives
slotSize = 4;
slotted = zeros(1, floor(count/slotSize));
index = 1;
for j = 1 : slotSize : count
    s = 0;
    for k = j : (j+slotSize-1)
        if k <= count
            s = s + data(k);
        end
    end
    slotted(index) = s;
    index = index + 1;
end

%subplot(2,1,1);
%plot(slotted);
%title('Naslotované dáta (prírastky), ve¾kos slotu: 4');

% cumulative
cumulative = zeros(1, floor(count/slotSize));
cumsum = 0;
for i = 1 : floor(count/slotSize)
    cumsum = cumsum + slotted(i);
    cumulative(i) = cumsum;    
end

%subplot(2,1,2);
%plot(cumulative);
%title('Naslotované dáta (kumulatívne), ve¾kos slotu: 4');

% histogram empirical
histogramE = zeros(1, slotSize + 1); %also zero value
for i = 1 : floor(count/slotSize)
    histogramE(slotted(i)+1) = histogramE(slotted(i)+1)+1; %index 0 avoid
end
%subplot(2,1,1);
% plot(0:slotSize, histogramE/floor(count/slotSize),);
% axis([0 slotSize 0 0.4]);
% title('Histogram nameraných, slotovaných dát, (ve¾kos slotu: 4)');

% histogram theoretical
histogramT = zeros(1, slotSize + 1); %also zero value
for i = 1 : slotSize
    histogramT(i) = binopdf(i, slotSize, cumsum/count); %index 0 avoid
end
%subplot(2,1,2);
%plot(0:slotSize, histogramT);
%axis([0 slotSize 0 0.4]);
%title('Histogram Bi(4; 0,543)');

% plot(0:slotSize, histogramE/floor(count/slotSize), 'b', 0:slotSize, histogramT, 'r');
% axis([0 slotSize 0 0.4]);
% title('Funkcia hustoty slotovaných dát, (ve¾kos slotu: 4) - modrá; Funkcia hustoty Bernoulliho rozdelenia - èervená');

% on/off
alfa = 0.7;
beta = 0.88;
gama = 0.5;
delta = 0.4;
epsilon = 0.8;
onoffdata = zeros(1, floor(count/slotSize));
% first state
r = rand();
if r < 0.2
    onoffdata(1) = 0;
elseif r < 0.4
    onoffdata(1) = 1;
elseif r < 0.6
    onoffdata(1) = 2;
elseif r < 0.8
    onoffdata(1) = 3;
else
    onoffdata(1) = 4; 
end

for i = 2 : floor(count/slotSize)
    if onoffdata(i-1) == 0
        %ak som v nule
        if rand() < alfa 
            %preskocim do jednotky
            onoffdata(i) = 1;
        else
            %inak ostavam v nule
            onoffdata(i) = 0;
        end
    elseif onoffdata(i-1) == 1
         if rand() < beta
            onoffdata(i) = 2;
         else   
            onoffdata(i) = 0;
        end
    elseif onoffdata(i-1) == 2
        if rand() < gama
            onoffdata(i) = 3;
         else   
            onoffdata(i) = 1;
        end
    elseif onoffdata(i-1) == 3
        if rand() < delta
            onoffdata(i) = 4;
         else   
            onoffdata(i) = 2;
        end
    else
         if rand() < epsilon
            onoffdata(i) = 3;
         else   
            onoffdata(i) = 4;
        end
    end
end

% histogram on/off
histogramOnOff = zeros(1, slotSize + 1); %also zero value
for i = 1 : floor(count/slotSize)
    histogramOnOff(onoffdata(i)+1) = histogramOnOff(onoffdata(i)+1)+1; %index 0 avoid
end
% subplot(2,1,2);
% plot(0:slotSize, histogramOnOff/floor(count/slotSize));
% axis([0 slotSize 0 0.4]);
% title('Histogram On/Off procesu (0,7; 0,88, 0.5, 0.4, 0.8)');

plot(0:slotSize, histogramE/floor(count/slotSize), 'b', 0:slotSize, histogramOnOff/floor(count/slotSize), 'r');
title('Funkcia hustoty slotovaných dát, (ve¾kos slotu: 4) - modrá; Funkcia hustoty On/Off procesu - èervená');
