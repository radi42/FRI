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
    h_4 = vektorNaHistogram(v_4, 4)
    h_8 = vektorNaHistogram(v_8, 8)
    h_16 = vektorNaHistogram(v_16, 16)
    
%#########################################################################
%     porovnat histogramy s teoretickymi rozdeleniami Bi(n,p)
%#########################################################################
%     Teoreticke pocetnosti
    teor_4 = dlzka_simulacie .* teorBinomPDF(4, p)
    teor_8 = dlzka_simulacie .* teorBinomPDF(8, p)
    teor_16 = dlzka_simulacie .* teorBinomPDF(16, p)
    
    diff_4 = porovnaj(h_4, teor_4, 4)
    diff_8 = porovnaj(h_8, teor_8, 8)
    diff_16 = porovnaj(h_16, teor_16, 16)
    
%#########################################################################
%     Otestuj toky chi-kvadrat testom
%#########################################################################





%#########################################################################
%     Navrhnut dlzky simulacie pre 16ts tak, aby bola zhoda s teoretickym 
%     rozdelenim pri Bi(16,p)
%#########################################################################
end

% Funkcia simulacie Bernoulliho toku
% n - casove okno
% p - pravdepodobnost uspechu
% sim_len - dlzka simulacie
function tok = bernTokSim(n, p, sim_len)
    tok = binornd(n, p, 1, sim_len);
end

% Konvertuj vektor na histogram - zahrn vsetky hodnoty <0; timeslot> =>
% pocet hodnot je 'timeslot+1'
function hist = vektorNaHistogram(v, timeslot)
    figure,hist = histogram(v, timeslot+1);
end

% Vypocitaj teoreticku pravdepodobnost binomickeho rozdelenia
function teor = teorBinomPDF(timeslot, p)
    x = 0:timeslot;
    teor = binopdf(x, timeslot, p);
    figure,plot(x,teor,'+')
end

% Porovnaj nameranu pocetnost (histogram Y os) a teoreticku pocetnost
function rozdiel = porovnaj(histogram, teorPoc, timeslot)
    x = (0:1:timeslot)
    histogram
    teorPoc
    figure,plot(x, histogram.Values, 'O', x, teorPoc, 'X');
    rozdiel = histogram.Values - teorPoc
end