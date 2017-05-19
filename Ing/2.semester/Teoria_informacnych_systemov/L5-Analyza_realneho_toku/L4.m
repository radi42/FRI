velkostTimeslotu = 0.004;
% velkostTimeslotu = 0.05;
cesta = 'E:\Skola\2. semester\TIS\Labaky\L4\M5.txt';
A = importdata(cesta);

medzery = minus(A(2:end),A(1:end-1));
% histMedzery = hist(medzery, 5);
% sumHist = sum(histMedzery);
% histMedzery = histMedzery / sumHist;
% plot(histMedzery, 'r');
% hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histogramy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hist(medzery,4);
figure();
hist(medzery,5);
figure();
hist(medzery,6);
figure();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erlang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ET = mean(medzery);
% smerOdch = std(medzery);
% ni = smerOdch/ET;
% n = 1/ni;
% b = n / ET;
% 
% y = randraw('erlang', [b, round(n)], 14970);
% % % y = round(y);
% hy = hist(y);
% sumHy = sum(hy);
% hy = hy/sumHy;
% plot(hy, 'b');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A = A(1:1500000,1);

% slotovani
pocetSlotov = floor(A(end)/velkostTimeslotu);

pom = 0;
pom2 = velkostTimeslotu;
sloty = zeros(pocetSlotov,1);
j = 1;
zaciatok = 0;

% cyklus spocita vyskyt paketov v timeslotoch
for i= 1:pocetSlotov
    while (A(j,1) >= pom  && A(j,1) < pom2)
        sloty(i,1) = sloty(i,1) + 1;
        j = j + 1;
    end
    pom = pom + velkostTimeslotu;
    pom2 = pom2 + velkostTimeslotu;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% slotovanie na 4., Bernoulli Poisson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bernoulli = binornd(4, 0.1, 1, 14970);
% 
% poisson = poissrnd(0.3, 1, 14970);
% 
% histSloty = hist(sloty,5);
% plot(histSloty, 'r');
% % figure();
% % title('Histogram pôvodného toku');
% % axis([-inf inf 0 15000]);
% % figure();
% hold on;
% 
% histBern = hist(bernoulli,5);
% plot(histBern, 'g');
% % axis([-inf inf 0 15000]);
% % figure();
% hold on;
% 
% histPois = hist(poisson,5);
% plot(histPois, 'b');
% axis([-inf inf 0 15000]);
% legend('Povodny tok', 'Bernoulli', 'Poisson', 'Fontsize', 12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% slotovanie na 4., urèi parametre MMRP pomocou pravdepodobnosti peaku
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
peakSum = 0;
peak = max(sloty);
avg = mean(sloty);
ppeak = peakSum / pocetSlotov;
p=zeros(peak+1, 1);
pempir=zeros(peak+1, 1);

for k = 1 : pocetSlotov
    if sloty(k) == 0
        pempir(1) = pempir(1) +1;
    elseif sloty (k) == 1
        pempir(2) = pempir(2) +1;
    elseif sloty(k) == 2
        pempir(3) = pempir(3) +1;
    elseif sloty(k) == 3
        pempir(4) = pempir(4) +1;
    elseif sloty(k) == 4
        pempir(5) = pempir(5) +1;
        peakSum = peakSum + 1;
    end
end

for l = 1 : (peak+1)
    pempir(l) = pempir(l) / pocetSlotov;
end

alfa = 1 - (ppeak*(peak/avg))^(1/(peak - 1));
beta = (avg*alfa)/(peak - avg);

% alfa = 1.02;
% beta = 0.01;

% hist(sloty);

pi1 = beta / (alfa + beta);
pi2 = alfa / (alfa + beta);


p(1) = pi2*(1-beta)^3;
p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
p(5) = pi1*(1-alfa)^3;

% figure();
x = linspace(0,4,5);
plot(x,p, 'r');
hold on;

plot(x, pempir, 'b');
% plot(pempir, 'b');
% plot(x, pempir, 'red');
% hold off;
legend('empiricke pravdepodobnosti','pravdepodobnosti pre proces MMRP');
% figure();
vzdialenost = zeros(1,1000000);
k=1;
minVzdialenost = 1000;
for i = 1:1000
    for j = 1:1000
        alfa = 0.5+(i/100);
        beta = 0.01+(j/100);
        pi1 = beta / (alfa + beta);
        pi2 = alfa / (alfa + beta);
        
        p(1) = pi2*(1-beta)^3;
        p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
        p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
        p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
        p(5) = pi1*(1-alfa)^3;
        
        vzdialenost(k)=sum(abs(p-pempir));
        
        if vzdialenost(k) < minVzdialenost
           minVzdialenost = vzdialenost(k);
           najAlfa = alfa;
           najBeta = beta;
        end
        
        k = k+1;
        
    end
end
% figure();
% plot(vzdialenost);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alfa = 1 - (ppeak*(peak/avg))^(1/(peak - 1));
% beta = (avg*alfa)/(peak - avg);
% 
alfa = najAlfa;
beta = najBeta;

% hist(sloty);

pi1 = beta / (alfa + beta);
pi2 = alfa / (alfa + beta);


p(1) = pi2*(1-beta)^3;
p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
p(5) = pi1*(1-alfa)^3;

figure();
x = linspace(0,4,5);
plot(x,p, 'r');
hold on;

plot(x, pempir, 'b');
% plot(pempir, 'b');
% plot(x, pempir, 'red');
% hold off;
legend('empiricke pravdepodobnosti','pravdepodobnosti pre proces MMRP');




