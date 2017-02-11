clc;
clear;
close all;

%config
maxVstup = 2;
Pp = 0.5;
maxVystup = 1;
% outputP = 0.08;
kapacBuff = 10;
kapacVystup = 1;
iteracie = 500;

stackSize = 0;
stats_inputFlow = zeros(1,iteracie);
stats_outputFlow = zeros(1,iteracie);
stats_dropCount = 0;
stats_bufferSize = zeros(1,iteracie);

for i = 1 : iteracie
 
	%receiving
	input = binornd(maxVstup, Pp);
%	fprintf('prislo: ');
%  disp(input);  
  
	if stackSize < kapacBuff 	
		stackSize = stackSize + input;
	end

%	fprintf('v stacku: ');
%  disp(stackSize);
	
	if stackSize > 0
		stats_outputFlow(i) = min(stackSize, kapacVystup);
  else
		stats_outputFlow(i) = 0;
	end
	
	%sending
	for j = 1 : kapacVystup
 		if stackSize > 0
				stackSize = stackSize - min(stackSize, kapacVystup);
 		end
	end
  
%  fprintf('po odvysielani: ');
%  disp(stackSize);

	stats_inputFlow(i) = input;
	stats_bufferSize(i) = stackSize;

end

maxBuffer = max(stats_bufferSize);
stats_bufferHistogram = zeros(1,maxBuffer+1);
for i = 1 : iteracie
  stats_bufferHistogram(stats_bufferSize(i)+1) = stats_bufferHistogram(stats_bufferSize(i)+1)+1;
end

figure('name', 'Tok');
subplot(2,1,1);
plot(stats_inputFlow);
axis([1 iteracie -0.1 maxVstup+0.1]);
title('Vstupny tok dat');
subplot(2,1,2);
plot(stats_outputFlow);
axis([1 iteracie -0.1 maxVystup+0.1])
title('Vystupny tok dat');

figure('name', 'Zasobnik');
subplot(2,1,1);
plot(stats_bufferSize);
axis([1 iteracie 0 max(stats_bufferSize)+1]);
title('Obsadenie zasobnika v case');
subplot(2,1,2);
bar(0:maxBuffer,stats_bufferHistogram);
axis([-0.5 maxBuffer+0.5 0 max(stats_bufferHistogram)+2]);
title('Histogram obsadenosti zasobnika');

disp('Vyuzitie vysielaca [%]');
disp(length(stats_outputFlow(stats_outputFlow>0))/iteracie*100);
