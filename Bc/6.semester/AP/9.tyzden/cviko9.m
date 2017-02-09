format short

f = [0 0 0 1 1 1 0 0 0 1 1 1 0 0 0 1 1 1 0 0 0]
t = 1:1:21

tt = linspace(0, length(f), 10000);

c = fft(f)./length(f)
ca = abs(c)

plot(t, ca)


%c(1) je stredna hodnota
%pozriem sa na amplitudove spektrum, zistim najvacsiu y hodnotu a zapiseme
%c(x), kde x je prisluchajuca hodnota k y na x-ovej osi
y1 = c(1)+2*real(c(4)) *cos((2*pi*3/length(f))*tt)-2*imag(c(4))*sin((2*pi*3/length(f))*tt);     %0 je stredna hodnota - posunutie na y osi
%y2 = y1 + 2*real(c(2)) *cos((2*pi*1/5)*tt)-2*imag(c(2))*sin((2*pi*1/5)*tt);
%brali sme preto c(3) a c(2), lebo tieto 2 su najvyznamnejsie uhly v datach

plot(t, f, tt, y1)
%plot(t, f, tt, y1, tt, y2)


%Cvicny priklad
f = [0 1 -2 2 -1]
t = [0 1 2 3 4]

tt = linspace(0, 4, 10000);

c = fft(f)./5
ca = abs(c)

%plot(t, ca)

y1 = 0+2*real(c(3)) *cos((2*pi*2/5)*tt)-2*imag(c(3))*sin((2*pi*2/5)*tt);     %0 je stredna hodnota - posunutie na y osi
y2 = y1 + 2*real(c(2)) *cos((2*pi*1/5)*tt)-2*imag(c(2))*sin((2*pi*1/5)*tt);

%plot(t, f, tt, y1, tt, y2)