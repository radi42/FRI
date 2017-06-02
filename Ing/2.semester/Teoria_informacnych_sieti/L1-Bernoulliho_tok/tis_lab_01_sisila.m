% V matlabe nasimulovat Bernoulliho tok, vstupné parametre su n, p, a dlzka simulacie,
%   - vytvorit slotovanie s casovym okonom 4, 8 a 16 ts, zobrazit
%   - porovnat histogramy s teoretickymi rozdeleniami Bi(n,p)
%   - otestovat zhodu rozdeleni na zaklade Chi^2 testu
%   - navrhnut dlzky simulacie pre 16ts tak, aby bola zhoda s teoretickym rozdelenim pri Bi(16,p)
%   - vyrobit strucnu ppt obsahuju vyznamne obrazky, uvahy a na konci matlabovsky kod

%#########################################################################
%#########################################################################

function Bernoulliho_tok()
    close all
    
    p = 0.5;
    dlzka_simulacie = 100;
%#########################################################################
%     vytvorit slotovanie s casovym okonom 4, 8 a 16 ts, zobrazit
%#########################################################################
%     Vygeneruj Bernoulliho tok
    v_4 = bernTokSim(4, p, dlzka_simulacie)
    v_8 = bernTokSim(8, p, dlzka_simulacie)
    v_16 = bernTokSim(16, p, dlzka_simulacie)
    
%     Zobraz histogram vygenerovanych Bernoulliho tokov
    h_4 = vektorNaHistogram(v_4, 4, 0)
    h_8 = vektorNaHistogram(v_8, 8, 0)
    h_16 = vektorNaHistogram(v_16, 16, 0)
    
%#########################################################################
%     porovnat histogramy s teoretickymi rozdeleniami Bi(n,p)
%#########################################################################
%     Teoreticke pocetnosti
    teor_pocetnost_4 = dlzka_simulacie .* teorBinomPDF(4, p, 0)
    teor_pocetnost_8 = dlzka_simulacie .* teorBinomPDF(8, p, 0)
    teor_pocetnost_16 = dlzka_simulacie .* teorBinomPDF(16, p, 0)
    
    diff_4 = porovnaj(h_4, teor_pocetnost_4, 4, 0)
    diff_8 = porovnaj(h_8, teor_pocetnost_8, 8, 0)
    diff_16 = porovnaj(h_16, teor_pocetnost_16, 16, 0)
    
%#########################################################################
%     otestovat zhodu rozdeleni na zaklade Chi^2 testu
%#########################################################################
    
    diff_4_squared = diff_4.^2
    diff_8_squared = diff_8.^2
    diff_16_squared = diff_16.^2
    
    diff_4_divided = diff_4_squared ./ teor_pocetnost_4
    diff_8_divided = diff_8_squared ./ teor_pocetnost_8
    diff_16_divided = diff_16_squared ./ teor_pocetnost_16
    
    chi_4_sum = sum(diff_4_divided)
    chi_8_sum = sum(diff_8_divided)
    chi_16_sum = sum(diff_16_divided)
    
    vyhodnot_chi_kvadrat(4, chi_4_sum)
    vyhodnot_chi_kvadrat(8, chi_8_sum)
    vyhodnot_chi_kvadrat(16, chi_16_sum)

%#########################################################################
%     Navrhnut dlzky simulacie pre 16ts tak, aby bola zhoda s teoretickym 
%     rozdelenim pri Bi(16,p)
%#########################################################################
% Monte Carlo

% monte_carlo parameter urcuje, ktore riadky kodu sa vykonaju pri
% Monte Carlo simulacii (hodnota 1), a ktore nie (hodnota 0). Pokial sa
% metody volaju zo standardneho kontextu, parameter ma hodnotu 0. Pokial sa
% ale volaju z Monte Carlo simulacie, parameter ma hodnotu 1.
%##################################

    priemerna_dlzka_simulacie = 0
    pocet_opakovani = 20
    minimum = 10000000000
    maximum = 0
    for c = 1:pocet_opakovani
        dlzka_simulacie = 10000
        while true
            v_16 = bernTokSim(16, p, dlzka_simulacie);
            h_16 = vektorNaHistogram(v_16, 16, 1);
            teor_pocetnost_16 = dlzka_simulacie .* teorBinomPDF(16, p, 1);
            diff_16 = porovnaj(h_16, teor_pocetnost_16, 16, 1);
            diff_16_squared = diff_16.^2;
            diff_16_divided = diff_16_squared ./ teor_pocetnost_16;
            chi_16_sum = sum(diff_16_divided);

            chi_vysledok = vyhodnot_chi_kvadrat(16, chi_16_sum);

            if chi_vysledok == 0
                priemerna_dlzka_simulacie = priemerna_dlzka_simulacie + dlzka_simulacie;

                % Najdi minimum
                % Aktualizacia minima
                if dlzka_simulacie < minimum
                    minimum = dlzka_simulacie;
                end
                
                % Najdi maximum
                if dlzka_simulacie > maximum
                    maximum = dlzka_simulacie;
                end
                break;
            end

            dlzka_simulacie = dlzka_simulacie + 10000
        end
    end
    
    priemerna_dlzka_simulacie = priemerna_dlzka_simulacie / pocet_opakovani
    minimum
    maximum
end

% Funkcia simulacie Bernoulliho toku
% n - casove okno
% p - pravdepodobnost uspechu
% sim_len - dlzka simulacie
function tok = bernTokSim(n, p, sim_len)
    tok = binornd(n, p, 1, sim_len);
end

% Konvertuj vektor na histogram
% Pocet kosov (intervalov/bins) je pocet moznych hodnot v timeslote t.j.
% vsetky hodnoty v intervale <0; timeslot> => pocet kosov je 'timeslot+1'
function hist = vektorNaHistogram(vektor, timeslot, monte_carlo)
    % Nevykonavaj riadok nizsie pri Monte Carlo
    if monte_carlo == 0
        figure,hist = histogram(vektor, timeslot+1);
    end
    % Vykonaj riadok nizsie pri Monte Carlo
    if monte_carlo == 1
        figure,hist = histogram(vektor, timeslot+1);
        set(gcf, 'Visible', 'off')
    end
    
%     switch timeslot
%         case 4
%             saveas(gcf,'namerane_pocetnosti_histogram_4.png')
%         case 8
%             saveas(gcf,'namerane_pocetnosti_histogram_8.png')
%         case 16
%             saveas(gcf,'namerane_pocetnosti_histogram_16.png')
%         otherwise
%             'Nespravny timeslot'
%     end
end

% Vypocitaj teoreticku pravdepodobnost binomickeho rozdelenia
function teor = teorBinomPDF(timeslot, p, monte_carlo)
    x = 0:timeslot;
    teor = binopdf(x, timeslot, p);
    % Nevykonavaj riadok nizsie pri Monte Carlo
    if monte_carlo == 0
        figure,plot(x,teor,'+');
    end
    
%     switch timeslot
%         case 4
%             saveas(gcf,'teor_pocetnosti_binomicke_rozdelenie_4.png')
%         case 8
%             saveas(gcf,'teor_pocetnosti_binomicke_rozdelenie_8.png')
%         case 16
%             saveas(gcf,'teor_pocetnosti_binomicke_rozdelenie_16.png')
%         otherwise
%             'Nespravny timeslot'
%     end
end

% Porovnaj nameranu pocetnost (histogram Y os) a teoreticku pocetnost
function rozdiel = porovnaj(histogram, teorPoc, timeslot, monte_carlo)
    x = (0:1:timeslot)
    % Nevykonavaj riadok nizsie pri Monte Carlo
    if monte_carlo == 0
        figure,plot(x, histogram.Values, 'O', x, teorPoc, 'X');
    end
    rozdiel = histogram.Values - teorPoc;
    
%     switch timeslot
%         case 4
%             saveas(gcf,'namerane_vs_teoreticke_pocetnosti_4.png')
%         case 8
%             saveas(gcf,'namerane_vs_teoreticke_pocetnosti_8.png')
%         case 16
%             saveas(gcf,'namerane_vs_teoreticke_pocetnosti_16.png')
%         otherwise
%             'Nespravny timeslot'
%     end
end

% Funkcia vyhodnoti chi kvadrat hodnotu na hladine vyznamnosti 0.01
% Ak je namerana chi kvadrat hodnota mensia ako tabulkova, hypotezu
% nezamietam
function zamietam = vyhodnot_chi_kvadrat(timeslot, chi_kvadrat_hodnota)
    stupne_volnosti = timeslot - 1 - 2
    zamietam = 1;
    switch timeslot
        case 4
%             1 stupen volnosti
            if chi_kvadrat_hodnota < 6.63
                zamietam = 0;
            end
%             return;
        case 8
%             5 stupnov volnosti
            if chi_kvadrat_hodnota < 15.09
                zamietam = 0;
            end
%             return;
        case 16
%             13 stupnov volnosti
            if chi_kvadrat_hodnota < 27.69
                zamietam = 0;
            end
%             return;
        otherwise
            'Neplatny timeslot'
    end
    
    zamietam
    
    if zamietam == 0
        'Hypotezu nezamietam'
    else
        'Hypotezu zamietam'
    end
end