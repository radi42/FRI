% Buffer Simulator - Simulator vyrovnavacej pamate pomocou Lindleyho
% rovnice
clear
close all

sim_len = 200;
n = 2;                          % max. pocet prichadzajucich paketov v case t
p1 = 0.7;                       % intenzita prichodu paketov
p2 = 0.5;                       % intenzita spracovania paketov
max_velkost_fronty = 10000;         % urcuje maximalnu velkost buffra (fronty)
buffer_size = repmat(max_velkost_fronty, sim_len, 1);   % max. velkost buffra
                                                    % "nekonecny" buffer - nikdy sa nezaplni
                                                    % konecny buffer - po prekroceni kapacity buffra sa zacnu pakety zahadzovat
time = linspace(1, sim_len, sim_len);       % casovy vektor - sluzi na zobrazovanie grafov

a = binornd(n, p1, 1, sim_len);     % prirastky - pocet paketov, ktore prisli v case t; binomicky rozdelené
c = binornd(n, p2, 1, sim_len);     % pocet naraz spracovatelnych paketov moze byt aj nahodny (bernoulliho) proces, pokial spracovavame viacero nezavislych tokov zaroven
q = zeros(1, sim_len);              % front (queue) - miesto, kde sa zaradzuju este nespracovane pakety

% Inicializacia
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
max_velkost_buffra = max(q);     % max. dlzka frontu

figure,plot(time, a);
figure,plot(time, c);
figure,plot(time, A);

figure,plot(time, A, time, B);

pravdepodobnosti = sprintf(' (p1 = %.1f, p2 = %.1f)', p1, p2);
kumulativny_prichod_a_spracovanie = strcat('Kumulatívny príchod a spracovávanie paketov', pravdepodobnosti);
title(kumulativny_prichod_a_spracovanie);
saveas(gcf, strcat('C:\Users\Andrej\Desktop\vstup_vystup_', pravdepodobnosti, '.png'));

figure, plot(time, q);
stav_frontu_vypis = strcat('Stav frontu ', pravdepodobnosti);
title(stav_frontu_vypis); 
saveas(gcf, strcat('C:\Users\Andrej\Desktop\buffer_', pravdepodobnosti, '.png'));

figure,plot(time, lost);
title('Zahodené pakety');

figure,plot(time, L);

figure,histogram(q, max_velkost_buffra);
histogram_vypis = strcat('Histogram ', pravdepodobnosti);
title(histogram_vypis);
saveas(gcf, strcat('C:\Users\Andrej\Desktop\buffer_histogram_', pravdepodobnosti, '.png'));