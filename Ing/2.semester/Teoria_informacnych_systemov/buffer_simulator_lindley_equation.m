% Buffer Simulator - Simulator vyrovnavacej pamate pomocou Lindleyho
% rovnice
clear
close all

sim_len = 100;
%sim_len = 10;
n = 2;                          % max. pocet prichadzajucich paketov v case t
p = 0.5;                        % pravdepodobnost nastatia udalosti
%buffer_size = repmat(10000, sim_len, 1);    % max. velkost buffra - "nekonecny" buffer
buffer_size = repmat(5, sim_len, 1);        % max. velkost buffra - po prekroceni kapacity buffra sa zacnu pakety zahadzovat
time = linspace(1, sim_len, sim_len);       % casovy vektor - sluzi na zobrazovanie grafov

a = binornd(n, p, 1, sim_len);  % prirastky - pocet paketov, ktore prisli v case t; binomicky rozdelené
%c = ones(1, sim_len);          % pocet naraz spracovatelnych paketov
c = binornd(n, p, 1, sim_len);   % pocet naraz spracovatelnych paketov moze byt aj nahodny (bernoulliho) proces, pokial spracovavame viacero nezavislych tokov zaroven
q = zeros(1, sim_len);          % front (queue) - miesto, kde sa zaradzuju este nespracovane pakety
%lost = zeros(1, sim_len);       % mnozstvo zahodenych paketov v case t

% Inicializacia
%a(1) = 0;
c(1) = 0;
q(1) = 0;

stav_buffra = zeros(1, sim_len);
for t = 2:sim_len
    % NEKONECNY BUFFER
    % aktualny stav buffra je: stav buffra predtym + pocet paketov, ktore
    % pred tym prisli - pocet paketov, ktore buffer dokaze teraz spracovat
    
    %q(t) = max(0, q(t-1) + a(t-1) - c(t));
    
    
    % KONECNY BUFFER
    stav_buffra(t) = q(t-1) + a(t-1) - c(t);
    if stav_buffra >= 0
        if stav_buffra > buffer_size(t)
            q(t) = buffer_size(t);
        else
            q(t) = min(buffer_size(t), stav_buffra(t));
        end
    else
        stav_buffra(t) = 0;
        q(t) = 0;
    end
end

A = cumsum(a);                  % kumulativne prirastky - sucet prvkov vektora a -> kumulativny pocet prichadzajucich paketov
B = A - q;                      % kumulativny pocet spracovanych paketov - odcitame pocet cakajucich od poctu prichadzajucich paketov
lost = stav_buffra - q;         % pocet zahodenych paketov
L = cumsum(lost);               % kumulativny pocet zahodenych paketov


% Kontrola vektorov - najlepsie sa robi, ked je dlzka simulacie 'sim_len'
% je najviac 10
if sim_len <= 10
    a
    c
    q
    stav_buffra
    lost
end

max(stav_buffra)                % teoreticka max. dlzka frontu
max(q)                          % max. dlzka frontu

figure,plot(time, a);
figure,plot(time, c);
figure,plot(time, A);
figure,plot(time, A, time, B);
figure, plot(time, q);
figure,plot(time, lost);
figure,plot(time, L);