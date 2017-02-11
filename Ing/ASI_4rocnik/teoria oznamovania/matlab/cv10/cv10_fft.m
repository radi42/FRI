y=[7,10,10];
disp(fft(y));
y1=fft(y)
for i=1:3
    y1(i)=y1(i)/3;
end;
disp(y1);
disp(fft(y1));

y2=fft(y1);
for i=1:3
    y2(i)=y2(i)/3;
end;
disp(y2);