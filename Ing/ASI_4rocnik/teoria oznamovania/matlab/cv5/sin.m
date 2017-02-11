%t = [0:1/30000:0.2];
%A = 1;
%f =10000;
%y = A*sin(2*pi*f*t);
%plot(t(1:100),y(1:100))

% Fs = 44100;
% t = [0:1/Fs:3-1/Fs]; %1 second, length 44100
% freq = 440; % Hz
% f1 = sin(2*pi*freq*t);
% sound(f1,Fs)
% %f2 = sin(2*pi*(2*freq)*t);
% %sound(f2,Fs)
% period: (1/freq*Fs)
% figure(1);plot(f1)
% figure(2);plot(f1(1:round(1/freq*Fs+1)))
% 
% wavwrite(f1,Fs,'440Hz.wav')

for k = 1:5
    fs = 44100;
    t = 0:1/fs:2;
    f = 440;
    c = 1;
    
    y = c*sin(2.*pi.*f.*t);
    plot(t(1:1000),y(1:1000));
    sound(y,fs,16);
end;

