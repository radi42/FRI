clc;
clear;
close all;

%config
inputN = 2;
inputP = 0.5;
outputN = 1;
% outputP = 0.08;
bufferMaxSize = Inf;
outputCapacity = 1;
iterationsCount = 500;

stackSize = 0;
stats_inputFlow = zeros(1,iterationsCount);
stats_outputFlow = zeros(1,iterationsCount);
stats_dropCount = 0;
stats_bufferSize = zeros(1,iterationsCount);

for i = 1 : iterationsCount
 
	%receiving
	input = binornd(inputN, inputP);
%	fprintf('prislo: ');
%  disp(input);  
  
	if stackSize < bufferMaxSize 	
		stackSize = stackSize + input;
	end

%	fprintf('v stacku: ');
%  disp(stackSize);
	
	if stackSize > 0
		stats_outputFlow(i) = min(stackSize, outputCapacity);
  else
		stats_outputFlow(i) = 0;
	end
	
	%sending
	for j = 1 : outputCapacity
 		if stackSize > 0
				stackSize = stackSize - min(stackSize, outputCapacity);
 		end
	end
  
%  fprintf('po odvysielani: ');
%  disp(stackSize);

	stats_inputFlow(i) = input;
	stats_bufferSize(i) = stackSize;

end

maxBuffer = max(stats_bufferSize);
stats_bufferHistogram = zeros(1,maxBuffer+1);
for i = 1 : iterationsCount
  stats_bufferHistogram(stats_bufferSize(i)+1) = stats_bufferHistogram(stats_bufferSize(i)+1)+1;
end

figure('name', 'Tok');
subplot(2,1,1);
plot(stats_inputFlow);
axis([1 iterationsCount -0.1 inputN+0.1]);
title('Vstupny tok dat');
subplot(2,1,2);
plot(stats_outputFlow);
axis([1 iterationsCount -0.1 outputN+0.1])
title('Vystupny tok dat');

figure('name', 'Zasobnik');
subplot(2,1,1);
plot(stats_bufferSize);
axis([1 iterationsCount 0 max(stats_bufferSize)+1]);
title('Obsadenie zasobnika v case');
subplot(2,1,2);
bar(0:maxBuffer,stats_bufferHistogram);
axis([-0.5 maxBuffer+0.5 0 max(stats_bufferHistogram)+2]);
title('Histogram obsadenosti zasobnika');

disp('Vyuzitie vysielaca [%]');
disp(length(stats_outputFlow(stats_outputFlow>0))/iterationsCount*100);
