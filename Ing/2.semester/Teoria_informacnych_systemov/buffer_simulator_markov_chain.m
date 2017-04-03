% Buffer Simulator - Simulator vyrovnavacej pamate cez Markovov retazec

n_in = 1;       % max. pocet naraz prichadzajucich paketov
p_in = 0.07;    % intenzita prichodu paketov

n_out = 1;      % max. pocet naraz spracovanych paketov
p_out = 0.05;   % intenzita odchodu paketov

buffer_size = 4;    % kapacita buffra - max. pocet paketov, ktore dokaze ulozit
pocet_stavov = buffer_size + 2; % pocet stavov = velkost buffrra + 1 (0 az 4 => 5 stavov) + vysielaci stav (odchod paketu z buffra)

alfa = (p_in * (1 - p_out)) / ((1 - p_in) * p_out);

% MOCNINY AFLY - vektor na pomocny vypocet
Q = zeros(1, pocet_stavov);
Q(1) = 1;

for m=2:pocet_stavov
    Q(m) = alfa^(m-1);
end

% sucet mocnin dvojky - uzitocne pre vypocet pi_0
Q_sum = sum(Q);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% PRAVDEPODOBNOSTI STAVOV
pi_ka = zeros(1, pocet_stavov);
pi_ka(1) = Q(1) / Q_sum;

for m=2:pocet_stavov
    pi_ka(m) = Q(m) * pi_ka(1);
end

sum_pi_ka = sum(pi_ka);

% Q
display('PRAVDEPODOBNOSTI STAVOV')
pi_ka


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% KONTROLA NUTNEJ PODMIENKY
display('Je sucet pravdepodobnosti 1?')
if sum_pi_ka ~= 1
    display('NIE!')
else
    display('ANO')
end

display('___________________________________________')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% PRIEMERNY POCET PAKETOV V DANOM STAVE
k_pi_ka = zeros(1, pocet_stavov);
for m=1:pocet_stavov
    k_pi_ka(m) = (m-1) * pi_ka(m);
end

display('PRIEMERNY POCET PAKETOV V DANOM STAVE')
k_pi_ka
display('___________________________________________')

% PRIEMERNY POCET PAKETOV V CELOM SYSTEME
sum_k_pi_ka = sum(k_pi_ka);

display('PRIEMERNY POCET PAKETOV V CELOM SYSTEME')
sum_k_pi_ka
display('___________________________________________')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% PRIEMERNA DLZKA FRONTY V DANOM STAVE
queue_size = zeros(1, buffer_size); 
% velkost vektora 'queue_size' je preto taka ('buffer_size'), lebo v
% bufferi moze cakat 1 az buffer_size paketov. ked necaka ziaden paket,
% netvori sa fronta, preto tento stav ignorujeme
for m=1:buffer_size
    queue_size(m) = m * pi_ka(m+2);
end

% PRIEMERNA DLZKA FRONTY V CELOM SYSTEME
sum_queue_size = sum(queue_size);

display('PRIEMERNA DLZKA FRONTY V CELOM SYSTEME')
sum_queue_size
display('___________________________________________')

% PRIEMERNY STAV OBSLUHY

priemerny_stav_obsluhy = sum(pi_ka(2:pocet_stavov)) / 1;
% ta '1' je v menovateli preto, lebo mame iba jedno oblsuzne miesto na 
% spracovanie paketov

display('PRIEMERNY STAV OBSLUHY')
priemerny_stav_obsluhy
display('___________________________________________')