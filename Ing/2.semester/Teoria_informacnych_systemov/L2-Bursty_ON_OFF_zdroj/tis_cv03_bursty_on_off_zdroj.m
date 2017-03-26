function BurstOnOffZdroj()
    close all
    dlzka_simulacie = 1000;
    p = 0.8;

    alfa = 0.09;
    beta = 0.03;
    burst_on_off_generator(p, alfa, beta, dlzka_simulacie, 1);
    
    alfa = 0.07;
    beta = 0.93;
    burst_on_off_generator(p, alfa, beta, dlzka_simulacie, 2);
    
    alfa = 0.82;
    beta = 0.18;
    burst_on_off_generator(p, alfa, beta, dlzka_simulacie, 3);
    
    alfa = 0.73;
    beta = 0.59;
    burst_on_off_generator(p, alfa, beta, dlzka_simulacie, 4);
end

% Generator Burst ON/OFF toku
% 2 stavy, default stav = 1 (zapnuty)
% parametre: 
%   p - pravdepodobnost, ze zostanem v stave 'on'
%   alfa - prechod z on do off
%   beta - prechod z off do on
%   pocet simulacii
%   cis_sim - cislo simulacie pre nazvy ukladanych grafov
function burst_on_off_generator(p, alfa, beta, dlzka_simulacie, cis_sim)
    a = zeros(1,dlzka_simulacie);   % vystupny burst tok

    % Na zaciatku predpokladame, ze je zdroj zapnuty
    a(1) = 1;

    % Ideme od dvojky - prvy prvok nemenime
    for i = 2:dlzka_simulacie
       if a(i-1) == 0
           if rand() < beta
               a(i) = 1;
           else
               a(i) = 0;
           end
       else
           if rand() < alfa
               a(i) = 0;
           else
               a(i) = 1;
           end
       end
    end

    % Priebezne odhaduj parameter 'p'
    a_sum = zeros(1, dlzka_simulacie);
    p_odhad = zeros(1, dlzka_simulacie);
    for i = 1:dlzka_simulacie
        a_sum(i) = sum(a(1:i));
        p_odhad(i) = a_sum(i) / i;
    end

    t = 1:dlzka_simulacie;
    figure,plot(a)
    axis([0 dlzka_simulacie -0.1 2])
    
    switch cis_sim
        case 1
            saveas(gcf, 'bursty_1.png');
        case 2
            saveas(gcf, 'bursty_2.png');
        case 3
            saveas(gcf, 'bursty_3.png');
        case 4
            saveas(gcf, 'bursty_4.png');
    end
    
    figure,plot(t, p_odhad, t, 1-p_odhad)
    axis([0 dlzka_simulacie -0.1 1.1])
    
    switch cis_sim
        case 1
            saveas(gcf, 'konvergencia_1.png');
        case 2
            saveas(gcf, 'konvergencia_2.png');
        case 3
            saveas(gcf, 'konvergencia_3.png');
        case 4
            saveas(gcf, 'konvergencia_4.png');
    end

    % Vypocitaj konvergenciu analyticky
    P = [p 1-p; beta alfa]
    p_init = [1 0]

    odhad_pravdepodobnosti = P^30
end