clear
close all

% Nacitame originalny obrazok
fRGB = imread('C:\Users\IEUser\Desktop\baboon.jpg');
f = rgb2gray(fRGB);
figure,imshow(f);title('Povodny obrazok');
w=imread('C:\Users\IEUser\Desktop\lena.jpg');
figure,imshow(w);title('Watermark');
alpha=0.5;

% Zmiesame watermark s originalnym obrazkom 
Fw = (1-alpha)*f + alpha.*w;
figure,imshow(Fw);title('Watermarkovany obrazok');
imwrite(Fw, 'C:\Users\IEUser\Desktop\baboon-watermarked.jpg');