picture = imread('C:\Users\Public\Pictures\Sample Pictures\Desert.jpg');
%imagesc(picture);
green = picture(:,:,2);
[c,s]=wavedec2(green,2,'haar');
%imagesc(green);

[H1,V1,D1] = detcoef2('all',c,s,1);
A1 = appcoef2(c,s,'haar',1);
V1img = wcodemat(V1,255,'mat',1);
H1img = wcodemat(H1,255,'mat',1);
D1img = wcodemat(D1,255,'mat',1);
A1img = wcodemat(A1,255,'mat',1);

%imagesc(V1img)
%imagesc(H1img)
%imagesc(D1img)
%imagesc(A1img)

[H2,V2,D2] = detcoef2('all',c,s,2);
A2 = appcoef2(c,s,'haar',2);
V2img = wcodemat(V2,255,'mat',1);
H2img = wcodemat(H2,255,'mat',1);
D2img = wcodemat(D2,255,'mat',1);
A2img = wcodemat(A2,255,'mat',1);

%imagesc(V2img)
%imagesc(H2img)
%imagesc(D2img)
%imagesc(A2img)
