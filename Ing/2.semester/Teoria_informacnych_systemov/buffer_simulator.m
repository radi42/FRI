% Buffer Simulator - Simulator vyrovnavacej pamate
clear
close all

sim_len = 1000000;
n = 2;                          % max. pocet prichadzajucich paketov v case t
p = 0.5;                        % pravdepodobnost nastatia udalosti
buffer_size = 1000;             % max. velkost buffra - po prekroceni kapacity buffra sa zacnu pakety zahadzovat
time = linspace(1, sim_len, sim_len);   % casovy vektor - sluzi na zobrazovanie grafov

a = binornd(n, p, 1, sim_len);  % prirastky - pocet paketov, ktore prisli v case t; binomicky rozdelené
c = ones(1, sim_len);           % pocet naraz spracovatelnych paketov
q = zeros(1, sim_len);          % front (queue) - miesto, kde sa zaradzuju este nespracovane pakety

% Inicializacia
a(1) = 0;
c(1) = 0;
q(1) = 0;

for t = 2:sim_len
    q(t) = max(0, q(t-1) + a(t) - c(t));
end

A = cumsum(a);                  % kumulativne prirastky - sucet prvkov vektora a
B = A - q;                      % kumulativny pocet spracovanych paketov - odcitame pocet cakajucich paketov od poctu pricha
max(q)                          % max. dlzka frontu

figure,plot(time, A);
figure,plot(time, A, time, B);
figure, plot(time, q, '-');