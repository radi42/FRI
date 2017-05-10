% Analýza výskytu paketov v nameranom PCAP zázname
% 
% 1. 3 rôzne histogramy pod?a zvolených tried a vhodné zobrazenie medzier (prírastkové a kumulatívne)
% 
% 2. A aproximova? pomocou Erlangových rozdelení
% 
% 3. slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy
% 
% 4. slotovanie na 4., ur?i? parametre MMRP pomocou pravdepodobnosti peaku
% 
% 5. slotovanie na 4., zlepši? parametre MMRP (numericky, znížením vzdialenosti)
clear
close all

times = csvread('C:\Users\Andrej\Desktop\m4.csv');

%==========================================================================
%3 rôzne histogramy pod?a zvolených tried
figure, histogram(times, 4);
figure, histogram(times, 5);    % najkrajsi graf
figure, histogram(times, 6);

%vhodné zobrazenie medzier (prírastkové a kumulatívne)
figure, plot(times);

m_cumul = cumsum(times);
figure, plot(m_cumul);


%==========================================================================
% 2. A aproximova? pomocou Erlangových rozdelení
% ET = repmat(mean(times), size(times), 1);
% odchylka = (sum((times - ET)))^2
% 
% ni = odchylka / ET(1)
% 
% n = 1/ni
% 
% b = n / ET(1)
% 
% f := stats::erlangPDF(2, 1):
% f(-infinity), f(-PI), f(1/2), f(0.5), f(PI), f(infinity)

ET = mean(times);
odchylka = std(times);
ni = odchylka / ET(1);
n = 1/ni
b = n / ET(1)

%==========================================================================
% 3. slotovanie na 4, otestovat Bernoulliho a Poissonove modely , histogramy
min_medzera = min(times)

