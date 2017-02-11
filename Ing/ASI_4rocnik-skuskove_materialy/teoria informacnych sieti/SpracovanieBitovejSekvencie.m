clc;
clear all;
close all;
format short;

data = load('6meranie4050.txt');
[~,count] = size(data);

figure(1, 'name', 'Priebeh naslotovanych dat');
figure(2, 'name', 'Histogramy naslotovanych dat');
figure(3, 'name', 'Porovnanie s Bernoulliho procesom a On/Off procesom');

n = 0;
for slotSize = [4 8 16 32]
	n=n+1;
	slotted = zeros(1, floor(count/slotSize));
	index = 1;
	histogram = zeros(1,slotSize+1);
	for j = 1 : slotSize : count
		s = 0;
		for k = j : (j+slotSize-1)
			if k <= count
				s = s + data(k);
			end
		end
		slotted(index) = s;
		index = index + 1;
		histogram(s+1) = histogram(s+1)+1;
	end

	figure(1);
	subplot(4,2,n*2-1);
	plot(slotted);
	axis([0 floor(count/slotSize)]);
	title(sprintf('Naslotovane data (prirastky), velkost slotu: %d', slotSize));
	cumulative = zeros(1, floor(count/slotSize));
	cumsum = 0;
	for i = 1 : floor(count/slotSize)
		cumsum = cumsum + slotted(i);
		cumulative(i) = cumsum;    
	end
	subplot(4,2,n*2);
	plot(cumulative);
	axis([0 floor(count/slotSize)]);
	title(sprintf('Naslotovane data (kumulativne), velkost slotu: %d', slotSize));
	
	figure(2);
	subplot(2,2,n);
	bar(0:slotSize,histogram);
	set(gca,'xtick',[0:ceil(slotSize/8):slotSize]);
	title(sprintf('Histogram slotovanych dat, velkost slotu: %d', slotSize));
	
	if slotSize == 4
		bernoulli = zeros(1, slotSize + 1);
		for i = 1 : slotSize
    		bernoulli(i) = binopdf(i, slotSize, sum(slotted)/count);
		end
	
		peak = max(slotted);
		avg = sum(slotted) / floor(count / slotSize);
		peakP = histogram(slotSize+1) / floor(count / slotSize);
		
		a = 1 - (peakP * peak / avg) ^ (1 / (peak - 1));
		b = (avg * a) / (peak - avg);
		
		pi(1)=b/(a+b);
		pi(2)=a/(a+b);
		
		onoff(1)=pi(2)*(1-b)^3;
		onoff(2)=(pi(1)*a+pi(2)*b)*(1-b)^2+2*a*b*(1-b)*pi(2);
		onoff(3)=(pi(1)*a+pi(2)*b)*(1-a)*(1-b)+a*b*(pi(1)*a+pi(2)*b+pi(1)*(1-b)+pi(2)*(1-a));
		onoff(4)=(pi(1)*a+pi(2)*b)*(1-a)^2+2*a*b*(1-a)*pi(1);
		onoff(5)=pi(1)*(1-a)^3;
		
		figure(3);
		plot(0:4, histogram./floor(count / slotSize), 0:4, bernoulli,0:4, onoff);
		
		legend('Namerane data');
        
		sprintf('Bernoulliho proces ~ Bi(%d, %0.3f)', slotSize, cumsum/count);
		sprintf('On/Off proces ~ alfa=%0.3f, beta=%0.3f', a, b);
		
	end

end