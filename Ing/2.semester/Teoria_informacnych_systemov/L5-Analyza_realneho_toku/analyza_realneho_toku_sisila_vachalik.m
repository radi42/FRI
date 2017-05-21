% Analyza vyskytu paketov v nameranom PCAP zazname
% 
% 1.) 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie medzier (prirastkove a kumulativne)
% 2.) Aproximovat pomocou Erlangovych rozdeleni
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy
% 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku
% 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)

clear
close all

% addpath('[C:\Users\Andrej\Desktop]');

times = csvread('m4.csv');

%==========================================================================
% 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie 
% medzier (prirastkove a kumulativne)

figure, histogram(times, 4);
figure, histogram(times, 5);    % najkrajsi graf
figure, histogram(times, 6);

% Prirastkove medzery
figure, plot(times);

% Kumulativne medzery
m_cumul = cumsum(times);
figure, plot(m_cumul);


%==========================================================================
% Aproximovat pomocou Erlangovych rozdeleni

ET = mean(times);
odchylka = std(times);
ni = odchylka / ET;     % ni - koeficient variability
n = 1/ni
b = n / ET

n = floor(n)            % n zaokruhlime nadol, aby sme ziskali vacsiu 
                        % variabilitu

% %TODO - vykreslit erlanga
% %TODO - odkial sme dostali 14970?
% 
% %erlang = randraw('erlang', [b, n], 14970);
% %erlang(1) = pdf('Gamma',0,b,n);
% 
% % erlang(1) = gampdf(0,b,n);
% % erlang(2) = gampdf(1,b,n);
% % erlang(3) = gampdf(2,b,n);
% % erlang(4) = gampdf(3,b,n);
% % erlang(5) = gampdf(4,b,n);
% 
% % erlang
% 
% % histErlang = hist(erlang);
% % sumHistErlang = sum(histErlang);
% % histErlang = histErlang/sumHistErlang;
% % plot(histErlang, 'b');





%==========================================================================
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy

min_medzera = min(times)
%zmanipulujeme minimalnu medzeru
min_medzera = 0.0001;

% histogram = histogram(times, 4);
% histogram_ts_4 = histogram.Values;
% histogram_ts_4
% figure,plot(histogram_ts_4, '-');

% Nasekat podla najmensej medzery -> Nascitat -> Urobit histogram
celkovy_cas = sum(times)
casy_prichodov_paketov = cumsum(times);
velkost_datasetu = size(times, 1)
casy_prichodov_paketov(velkost_datasetu)

pocetSlotov = ceil(casy_prichodov_paketov(velkost_datasetu) / min_medzera)
nasekane = zeros(1, pocetSlotov);
pocet_prich_paketov = 0;
index_nasekane = 1;

% nastavime interval. v tomto casovom intervale budeme sledovat, kolko
% paketov prislo
akt_cas = 0;
horna_hranica = akt_cas + min_medzera;

for k = 1 : velkost_datasetu(1)
    casy_prichodov_paketov(k);
    index = ceil(casy_prichodov_paketov(k) / min_medzera);
    nasekane(index) = nasekane(index) + 1;
end

kontrola_poctu_paketov = 0;
for k = 1 : pocetSlotov
    if nasekane(k) ~= 0
        kontrola_poctu_paketov = kontrola_poctu_paketov + nasekane(k);
    end
end

kontrola_poctu_paketov

% while akt_cas <= celkovy_cas
%     for k = 1 : velkost_datasetu(1)
%         if casy_prichodov_paketov(k) < horna_hranica
%             if casy_prichodov_paketov(k) >= akt_cas
%                 %akt_cas
%                 %casy_prichodov_paketov(k)
%                 pocet_prich_paketov = pocet_prich_paketov + 1;
%                 %pocet_prich_paketov
%             end
%         end
%     end
%     
%     nasekane(index_nasekane) = pocet_prich_paketov;
%     akt_cas = akt_cas + min_medzera;
%     horna_hranica = akt_cas + min_medzera;
%     
%     pocet_prich_paketov = 0;
%     index_nasekane = index_nasekane + 1;
% end
%
% velkost_nasekanych = size(nasekane)
% velkost_nasekanych(2)
% pocet_paketov = 0;
% for k = 1 : velkost_nasekanych(2)
%     if (nasekane(k) >= 1)
%         pocet_paketov = pocet_paketov + 1;
%     end
% end
% 
% pocet_paketov

j = 1;  % index vo vektore ucesanych prichodov paketov
po_kolko_ceseme = 250;
tmp3 = pocetSlotov / po_kolko_ceseme
ucesana_velkost = ceil(pocetSlotov / po_kolko_ceseme)
ucesane = zeros(1, ucesana_velkost);

sucet_nasekanych = 0;
dolna_hranica = 1;
horna_hranica = po_kolko_ceseme;

for i = 1 : ucesana_velkost
    ucesane(j) = sum(nasekane(dolna_hranica:horna_hranica));
    dolna_hranica = horna_hranica + 1;
    
    if (horna_hranica + po_kolko_ceseme) > pocetSlotov
        horna_hranica = pocetSlotov;
    else
        horna_hranica = horna_hranica + po_kolko_ceseme;
    end
    j = j + 1;
end

%kontrola
sum(ucesane)

% Porovnanie nameranych dat s Bernouliho a Poissonovym rozdelenim
[ucesany_orig_vektor] = hist(ucesane,5);
ucesany_orig_vektor

bernoulli = binornd(4, 0.11, 1, ucesana_velkost);
poisson = poissrnd(0.7, 1, ucesana_velkost);

histBern = histogram(bernoulli,5);
[ucesany_bern_vektor]=hist(bernoulli,5);

histPois = histogram(poisson,5);
[ucesany_pois_vektor]=hist(poisson,5);


ucesany_bern_vektor
ucesany_pois_vektor

pocetnosti = 0:1:4
figure,plot(pocetnosti, ucesany_orig_vektor, pocetnosti, ucesany_bern_vektor, pocetnosti, ucesany_pois_vektor);
legend('Povodny tok', 'Bernoulli', 'Poisson');











% %==========================================================================
% % 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku
% 
% %TODO - absolutne nechapem, co sa tu deje
% 
% peakSum = 0;
% peak = max(sloty);
% avg = mean(sloty);
% ppeak = peakSum / pocetSlotov;
% p=zeros(peak+1, 1);
% pempir=zeros(peak+1, 1);
% 
% for k = 1 : pocetSlotov
%     if sloty(k) == 0
%         pempir(1) = pempir(1) +1;
%     elseif sloty (k) == 1
%         pempir(2) = pempir(2) +1;
%     elseif sloty(k) == 2
%         pempir(3) = pempir(3) +1;
%     elseif sloty(k) == 3
%         pempir(4) = pempir(4) +1;
%     elseif sloty(k) == 4
%         pempir(5) = pempir(5) +1;
%         peakSum = peakSum + 1;
%     end
% end
% 
% for l = 1 : (peak+1)
%     pempir(l) = pempir(l) / pocetSlotov;
% end
% 
% alfa = 1 - (ppeak*(peak/avg))^(1/(peak - 1));
% beta = (avg*alfa)/(peak - avg);
% 
% pi1 = alfa / (alfa + beta)
% pi2 = beta / (alfa + beta)
% 
% mmrp(1) = pi2 * (1 - beta) ^ 3;
% mmrp(2) = (pi1 * alfa + pi2 * beta) * (1 - beta) ^ 2 + 2 * alfa * beta(1 - beta) * pi2;
% mmrp(3) = (pi1 * alfa + pi2 * beta) * (1 - alfa) * (1 - beta) + alfa * beta(pi1 * alfa + pi2 * beta + pi1 * (1 - beta) + pi2 * (1 - alfa));
% mmrp(4) = (pi1 * alfa + pi2 * beta) * (1 - alfa) ^ 2 + 2 * alfa * beta(1 - alfa) * pi1;
% mmrp(5) = pi1 * (1 - alfa) ^ 3;
% 
% mmrp
% figure,plot(mmrp, '-');
% 
% % figure();
% x = linspace(0,4,5);
% plot(x,p, 'r');
% hold on;
% 
% %TODO - co je ten pempir?
% plot(x, pempir, 'b');
% % plot(pempir, 'b');
% % plot(x, pempir, 'red');
% % hold off;
% legend('empiricke pravdepodobnosti','pravdepodobnosti pre proces MMRP');
% % figure();
% 
% 
% 
% 
% 
% %==========================================================================
% % 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)
% 
% %TODO - otestovat numericke zlepsenie
% 
% vzdialenost = zeros(1,1000000);
% k=1;
% minVzdialenost = 1000;
% for i = 1:1000
%     for j = 1:1000
%         alfa = 0.5+(i/100);
%         beta = 0.01+(j/100);
%         pi1 = beta / (alfa + beta);
%         pi2 = alfa / (alfa + beta);
%         
%         p(1) = pi2*(1-beta)^3;
%         p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
%         p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
%         p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
%         p(5) = pi1*(1-alfa)^3;
%         
%         vzdialenost(k)=sum(abs(p-pempir));
%         
%         if vzdialenost(k) < minVzdialenost
%            minVzdialenost = vzdialenost(k);
%            najAlfa = alfa;
%            najBeta = beta;
%         end
%         
%         k = k+1;
%         
%     end
% end
% % figure();
% % plot(vzdialenost);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % alfa = 1 - (ppeak*(peak/avg))^(1/(peak - 1));
% % beta = (avg*alfa)/(peak - avg);
% % 
% alfa = najAlfa;
% beta = najBeta;
% 
% % hist(sloty);
% 
% pi1 = beta / (alfa + beta);
% pi2 = alfa / (alfa + beta);
% 
% 
% p(1) = pi2*(1-beta)^3;
% p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
% p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
% p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
% p(5) = pi1*(1-alfa)^3;
% 
% figure();
% x = linspace(0,4,5);
% plot(x,p, 'r');
% hold on;
% 
% plot(x, pempir, 'b');
% % plot(pempir, 'b');
% % plot(x, pempir, 'red');
% % hold off;
% legend('empiricke pravdepodobnosti','pravdepodobnosti pre proces MMRP');
% 
