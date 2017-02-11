clc
clear all

noiseKoeficient=0.3;
t=linspace(1,2*pi+1,100);
signal=sin(t)+noiseKoeficient*rand(size(t));

%extract every 50 element of signal (sampling)
sampledOutput = signal(1:5:end);
sampleT = t(1:5:end);
stem(sampleT,sampledOutput)
hold on

plot(t,signal);
hold on

plot(sampleT,sampledOutput,'r')

%stem(sampledOutput)