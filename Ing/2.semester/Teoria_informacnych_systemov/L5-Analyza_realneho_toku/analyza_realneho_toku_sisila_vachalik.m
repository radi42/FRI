% Analyza vyskytu paketov v nameranom PCAP zazname
% 
% 1.) 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie medzier (prirastkove a kumulativne)
% 2.) Aproximovat pomocou Erlangovych rozdeleni
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy
% 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku
% 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)

clear
close all

addpath('[C:\Users\Andrej\Desktop]');

times = csvread('m4.csv');

%==========================================================================
% 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie 
% medzier (prirastkove a kumulativne)

figure, histogram(times, 4);
figure, histogram(times, 5);    % najkrajsi graf
figure, histogram(times, 6);

% figure, plot(times);

m_cumul = cumsum(times);
% figure, plot(m_cumul);


%==========================================================================
% Aproximovat pomocou Erlangovych rozdeleni

ET = mean(times);
odchylka = std(times);
ni = odchylka / ET;     % ni - koeficient variability
n = 1/ni
b = n / ET

n = floor(n)            % n zaokruhlime nadol, aby sme ziskali vacsiu 
                        % variabilitu

%TODO - vykreslit erlanga
%TODO - odkial sme dostali 14970?

%erlang = randraw('erlang', [b, n], 14970);
%erlang(1) = pdf('Gamma',0,b,n);

% erlang(1) = gampdf(0,b,n);
% erlang(2) = gampdf(1,b,n);
% erlang(3) = gampdf(2,b,n);
% erlang(4) = gampdf(3,b,n);
% erlang(5) = gampdf(4,b,n);

% erlang

% histErlang = hist(erlang);
% sumHistErlang = sum(histErlang);
% histErlang = histErlang/sumHistErlang;
% plot(histErlang, 'b');

%==========================================================================
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy

min_medzera = min(times)
histogram = histogram(times, 4);
histogram_ts_4 = histogram.Values;
histogram_ts_4

% figure,plot(histogram_ts_4, '-');

%TODO - co znamena ten (end) pri datach?
%TODO - ako to naslotovat?
%TODO - ploty vykreslit jednym prikazom

velkostTimeslotu = 0.004;
pocetSlotov = floor(times(end)/velkostTimeslotu);
sloty = zeros(pocetSlotov,1);
histSloty = hist(sloty,5);
plot(histSloty, 'r');
bernoulli = binornd(4, 0.1, 1, 14970);

poisson = poissrnd(0.3, 1, 14970);

histSloty = hist(sloty,5);
plot(histSloty, 'r');
% figure();
% title('Histogram pôvodného toku');
% axis([-inf inf 0 15000]);
% figure();
hold on;

histBern = hist(bernoulli,5);
plot(histBern, 'g');
% axis([-inf inf 0 15000]);
% figure();
hold on;

histPois = hist(poisson,5);
plot(histPois, 'b');
axis([-inf inf 0 15000]);
legend('Povodny tok', 'Bernoulli', 'Poisson', 'Fontsize', 12);












%==========================================================================
% 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku

%TODO - absolutne nechapem, co sa tu deje

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

pi1 = alfa / (alfa + beta)
pi2 = beta / (alfa + beta)

mmrp(1) = pi2 * (1 - beta) ^ 3;
mmrp(2) = (pi1 * alfa + pi2 * beta) * (1 - beta) ^ 2 + 2 * alfa * beta(1 - beta) * pi2;
mmrp(3) = (pi1 * alfa + pi2 * beta) * (1 - alfa) * (1 - beta) + alfa * beta(pi1 * alfa + pi2 * beta + pi1 * (1 - beta) + pi2 * (1 - alfa));
mmrp(4) = (pi1 * alfa + pi2 * beta) * (1 - alfa) ^ 2 + 2 * alfa * beta(1 - alfa) * pi1;
mmrp(5) = pi1 * (1 - alfa) ^ 3;

mmrp
figure,plot(mmrp, '-');

% figure();
x = linspace(0,4,5);
plot(x,p, 'r');
hold on;

%TODO - co je ten pempir?
plot(x, pempir, 'b');
% plot(pempir, 'b');
% plot(x, pempir, 'red');
% hold off;
legend('empiricke pravdepodobnosti','pravdepodobnosti pre proces MMRP');
% figure();





%==========================================================================
% 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)

%TODO - otestovat numericke zlepsenie

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

