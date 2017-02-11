clear
close all

% Cesty k obrazkom musia byt platne. Predvolena cesta je "Pracovna plocha"!
% Je odporucane presunut skript aj s obrazkami na pracovnu plochu.

% Na export obrazkov je pouzity format PNG, pretoze je bezstratovy, ma
% mensiu velkost ako bezstratovy format BMP, ale ma vacsiu velkost ako
% format JPEG, ktory je stratovy (co je neziaduce)

% Nacitame originalny obrazok.
% xRGB = imread('C:\Users\IEUser\Desktop\greens.jpg');
xRGB = imread('C:\Users\IEUser\Desktop\baboon.jpg');

% Konverzia originalneho obrazku na B/W
x = double(rgb2gray(xRGB));
% figure,imshow(x/255);title('Povodny obrazok (ciernobiely)')
% imwrite(x/255, 'C:\Users\IEUser\Desktop\original_image_3.jpg');

watermark = double(imread('C:\Users\IEUser\Desktop\lena.jpg'));
% watermarkRGB = imread('C:\Users\IEUser\Desktop\watermark.jpg');

% Ak to bude hadzat error "Dimensions must agree", potom treba odkomentovat
% riadok nizsie Niekedy matlab nacita ciernobiely obrazok ako farebny,
% preto to padne. Riesenim je potom explicitne obrazok konvertovat na
% ciernobiely

% watermark = double(rgb2gray(watermarkRGB));

%%%%%%%%%% Watermarking %%%%%%%%%%

% Urob DCT na watermarku
dw = dct2(watermark);   % dw = DCT watermark
imwrite(dw, 'C:\Users\IEUser\Desktop\watermark_dct_spektrum_3.png');

% Pripocitaj watermark ku DCT transformovanemu originalnemu obrazku
sila = 0.01;    % intenzita spektra watermarku
wdx = x + sila * dw;   % wdx = Watermarked DCT x
figure,imshow(x/255);title('Povodny obrazok')
figure,imshow(watermark/255);title('Watermark')
figure,imshow(dw);title('Watermark po DCT tranformacii')
figure,imshow(wdx/255);title('Originalny obrazok s DCT spektrom watermarku')
obrazok = wdx/255;
% Ukladanie watermarkovaneho obrazku do roznych formatov na tersovanie
% imwrite(wdx/255, 'C:\Users\IEUser\Desktop\watermarked_image_3.jpg');
% imwrite(wdx/255, 'C:\Users\IEUser\Desktop\watermarked_image_3.bmp');
imwrite(wdx/255, 'C:\Users\IEUser\Desktop\watermarked_image_3.png');

%%%%%%%%%% Dewatermarking %%%%%%%%%%
% wdxRecovery = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3.jpg'));
% wdxRecovery = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3.bmp'));
wdxRecovery = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3.png'));

%%%%%%%%%%%% TESTOVANIE ROBUSTNOSTI %%%%%%%%%%%%
%%%%%%% KONARIK A TEXT %%%%%%%
% wdxRecovery = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3 - Copy (2).bmp'));

% wdxRGB = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3 - Copy (2).png'));
% wdxRecovery = rgb2gray(wdxRGB);

%%%%%%% OPICA A LENA %%%%%%%
% wdxRecovery = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3 - Copy.bmp'));

% wdxRGB = double(imread('C:\Users\IEUser\Desktop\watermarked_image_3 - Copy.png'));
% wdxRecovery = rgb2gray(wdxRGB);

% Odcitame povodny obrazok od watermarkovaneho, cim ziskame DCT spektrum watermarku
result = (wdxRecovery - x) * (1/sila);
% result = (wdx - x) * (1/sila);

figure,imshow(result);title('DCT spektrum watermarku')
watermark_extracted = idct2(result); % Na spektrum watermarku aplikujeme IDCT a zosilnime watermark
figure,imshow(watermark_extracted/255);title('watermark_extracted'); % Extrahovany watermark zobrazime
% imwrite(watermark_extracted/255, 'C:\Users\IEUser\Desktop\watermark_extracted_3.jpg');
% imwrite(watermark_extracted/255, 'C:\Users\IEUser\Desktop\watermark_extracted_3.bmp');
imwrite(watermark_extracted/255, 'C:\Users\IEUser\Desktop\watermark_extracted_3.png');