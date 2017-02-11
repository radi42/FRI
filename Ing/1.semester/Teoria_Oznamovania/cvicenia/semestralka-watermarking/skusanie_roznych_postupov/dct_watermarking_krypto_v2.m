clear
close all

% Nacitame originalny obrazok
x = double(imread('C:\Users\IEUser\Desktop\greens.jpg'));
figure,imshow(x/255);title('Povodny obrazok')
y = x;

% Vytvorime watermark - nahodny binarny sum rozmerov m x n, kde 'm' a 'n' 
% su rozmery originalneho obrazka.
[m, n] = size(y(:,:,1));
a = randi([0 1], m,n);
figure,imshow(a);title('Watermark')
save m.dat a -ascii     % Uloz pole 'a' do suboru

% Wasserzeichen
x1 = x(:,:,1);
x2 = x(:,:,2);
x3 = x(:,:,3);

% Vykonaj DCT na povodnom obrazku
dx1 = dct2(x1);
dx2 = dct2(x2);
dx3 = dct2(x3);

% Nastavime amplifikacny faktor watermarku 'g' na vysoku hodnotu, aby sme
% znehodnotili obrazok
g = 100000000000;
[rm,cm] = size(a);
dx1(1:rm,1:cm) = dx1(1:rm,1:cm) + g * a;
dx2(1:rm,1:cm) = dx2(1:rm,1:cm) + g * a;
dx3(1:rm,1:cm) = dx3(1:rm,1:cm) + g * a;

figure,imshow(dx1);title('DCT spektrum cervenej zlozky povodneho obrazku')
figure,imshow(dx2);title('DCT spektrum zelenej zlozky povodneho obrazku')
figure,imshow(dx3);title('DCT spektrum modrej zlozky povodneho obrazku')

y1 = idct2(dx1);
y2 = idct2(dx2);
y3 = idct2(dx3);

y(:,:,1) = y1;
y(:,:,2) = y2;
y(:,:,3) = y3;

% figure,imshow(y1);
% figure,imshow(y2);
% figure,imshow(y3);


figure; imshow(y/255);title('Watermarkovany obrazok')
imwrite(y/255, 'C:\Users\IEUser\Desktop\watermarked_image.jpg');

% Dewatermarking
z = y;
[r,c,s] = size(z);

load m.dat
y = z;
dy1 = dct2(y(:,:,1));
dy2 = dct2(y(:,:,2));
dy3 = dct2(y(:,:,3));

dy1(1:rm,1:cm) = dy1(1:rm,1:cm) - g * m;
dy2(1:rm,1:cm) = dy2(1:rm,1:cm) - g * m;
dy3(1:rm,1:cm) = dy3(1:rm,1:cm) - g * m;

y11 = idct2(dy1);
y22 = idct2(dy2);
y33 = idct2(dy3);

yy(:,:,1) = y11;
yy(:,:,2) = y22;
yy(:,:,3) = y33;


figure; imshow(yy/255),title('Zrekonstruovany povodny obrazok')  % Zobrazime povodny obrazok
imwrite(yy/255, 'C:\Users\IEUser\Desktop\extracted_original_image.jpg');

%Zdroje:
%https://www.youtube.com/watch?v=4pLqjESBIO0
%https://www.youtube.com/watch?v=bHr1BL7dw8o