% Analyza vyskytu paketov v nameranom PCAP zazname
% 
% 1.) 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie medzier (prirastkove a kumulativne)
% 2.) Aproximovat pomocou Erlangovych rozdeleni
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy
% 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku
% 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)

clear
close all

times = csvread('m4.csv');

%==========================================================================
% 1.) 3 rozne histogramy podla zvolenych tried a vhodne zobrazenie 
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
% 2.) Aproximovat pomocou Erlangovych rozdeleni

ET = mean(times);
odchylka = std(times);
ni = odchylka / ET;     % ni - koeficient variability
n = 1/ni
b = n / ET

n = round(n)            % n zaokruhlime nadol, aby sme ziskali vacsiu 
                        % variabilitu

% nevedel som vykreslit erlanga v matlabe











%==========================================================================
% 3.) slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy

%zmanipulujeme minimalnu medzeru
min_medzera = 0.0001;

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

naslotovany_orig_vektor_na_4 = zeros(1, 5);
peakSum = 0;
patky = 0;
for k = 1 : ucesana_velkost
    if ucesane(k) == 0
        naslotovany_orig_vektor_na_4(1) = naslotovany_orig_vektor_na_4(1) + 1;
    elseif ucesane(k) == 1
        naslotovany_orig_vektor_na_4(2) = naslotovany_orig_vektor_na_4(2) + 1;
    elseif ucesane(k) == 2
        naslotovany_orig_vektor_na_4(3) = naslotovany_orig_vektor_na_4(3) + 1;
    elseif ucesane(k) == 3
        naslotovany_orig_vektor_na_4(4) = naslotovany_orig_vektor_na_4(4) + 1;
    %elseif ucesane(k) == 4
    elseif ucesane(k) >= 4
        % za peak beriem aj tie pocetnosti, co je vacsie ako 4 a to pripocitam ku
        % pocetnostiam 4ky
        naslotovany_orig_vektor_na_4(5) = naslotovany_orig_vektor_na_4(5) + 1;
        peakSum = peakSum + 1;
%     elseif ucesane(k) == 5
%         patky = patky + 1;
    end
end

naslotovany_orig_vektor_na_4
% patky
peakSum

bernoulli = binornd(4, 0.09, 1, ucesana_velkost);
poisson = poissrnd(0.99, 1, ucesana_velkost);

histBern = histogram(bernoulli,5);
[hist_bern_val]=hist(bernoulli,5);

histPois = histogram(poisson,5);
[hist_poiss_val]=hist(poisson,5);


hist_bern_val
hist_poiss_val

pocetnosti = 0:1:4;
figure,plot(pocetnosti, naslotovany_orig_vektor_na_4, pocetnosti, hist_bern_val, pocetnosti, hist_poiss_val);
legend('Povodny tok', 'Bernoulli', 'Poisson');











%==========================================================================
% 4.) slotovanie na 4., urcit parametre MMRP pomocou pravdepodobnosti peaku

% Vytvorenie pravdepodobnosti vyskytu
pravdep_prichodu_paketov = naslotovany_orig_vektor_na_4 ./ ucesana_velkost

peak = max(ucesane)
avg = mean(ucesane)

% za peak beriem aj tie pocetnosti, co je vacsie ako 4 a to pripocitam ku
% pocetnostiam 4ky (vid Porovnanie s Bernoulli a Poissonom)
ppeak = peakSum / ucesana_velkost

alfa = 1 - (ppeak*(peak/avg))^(1/(peak - 1))
beta = (avg*alfa)/(peak - avg)

pi1 = alfa / (alfa + beta)
pi2 = beta / (alfa + beta)

mmrp(1) = pi2*(1-beta)^3;
mmrp(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
mmrp(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
mmrp(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
mmrp(5) = pi1*(1-alfa)^3;

mmrp
figure,plot(pocetnosti, pravdep_prichodu_paketov, pocetnosti, mmrp);
legend('Empiricke pravdepodobnosti','Pravdepodobnosti pre proces MMRP');








%==========================================================================
% 5.) slotovanie na 4., zlepsit parametre MMRP (numericky, znizenim vzdialenosti)

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
        
        vzdialenost(k)=sum(abs(p - pravdep_prichodu_paketov));
        
        if vzdialenost(k) < minVzdialenost
           minVzdialenost = vzdialenost(k);
           najAlfa = alfa;
           najBeta = beta;
        end
        
        k = k+1;
        
    end
end

alfa = najAlfa;
beta = najBeta;

pi1 = beta / (alfa + beta);
pi2 = alfa / (alfa + beta);


p(1) = pi2*(1-beta)^3;
p(2) = (pi1*alfa + pi2*beta)*(1-beta)^2+2*alfa*beta*(1-beta)*pi2;
p(3) = (pi1*alfa+pi2*beta)*(1-alfa)*(1-beta)+alfa*beta*(pi1*alfa+pi2*beta+pi1*(1-beta)+pi2*(1-alfa));
p(4) = (pi1*alfa+pi2*beta)*(1-alfa)^2 + 2*alfa*beta*(1-alfa)*pi1;
p(5) = pi1*(1-alfa)^3;

figure,plot(pocetnosti, pravdep_prichodu_paketov, pocetnosti, mmrp, pocetnosti, p);
legend('Empiricke pravdepodobnosti','Pravdepodobnosti pre proces MMRP', 'Vylepsene pravdepodobnosti MMRP');

%%Ukladanie grafov do suboru
% h = get(0,'children');
% for i=1:length(h)
%     %saveas(h(i), ['figure' num2str(i)], 'fig');
%     index = num2str(i);
%     saveas(h(i), strcat('C:\Users\Andrej\Desktop\obr_', index, '.png'));
% end