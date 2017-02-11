
vn=0.2;%noise amplitude
v=1;%voltage in volts
f=200;%frequency in Hertz
w=2*pi*f;
t=linspace(0,5,100)*1e-3;%time = 0 to 5ms
mysignal=v*sin(w*t)+vn*3*rand(size(t))-0.2;
figure;
%plot(t,mysignal);
xlabel('cas');
ylabel('signal');
zoom xon;

vzorky = zeros(1,100);



hold on; % make sure no new plot window is created on every plot command
plot(t,mysignal);

