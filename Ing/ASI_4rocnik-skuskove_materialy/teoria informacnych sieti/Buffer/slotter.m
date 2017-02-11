clear all;

lambda = 5;
count = 100;
data = exprnd(lambda,count,1);

cumdata = zeros(1, count);
cumdata(1) = data(1);
for i = 2 : count
    cumdata(i) = cumdata(i-1) + data(i);
end

% count = length(data);
% plot(data);
% 

subplot(3,1,1);
plot(cumdata);

medz = zeros(1, count);
for i = 2 : count
   medz(1) = cumdata(1);
   medz(i) = cumdata(i) - cumdata(i-1);
end

subplot(3,1,2);
plot(medz);
% title('nenaslotovane velkosti medzier medzi paketmi v sekundach')

slotSize = 5;

b = zeros(1, count/slotSize);
index = 1;
for j = 1 : slotSize : count
    s = 0;
    for k = j : (j+slotSize-1)
        s = s + medz(k);
    end
    b(index) = s;
    index = index + 1;
end

subplot(3,1,3);
plot(b);
% title('naslotovane velkosti medzier medzi paketmi v sekundach')
