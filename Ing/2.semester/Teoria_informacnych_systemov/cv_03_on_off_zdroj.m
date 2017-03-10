close all
    
p = 0.5;
dlzka_simulacie = 100;

% ON/OFF zdroj
hody_mincou = binornd(1, p, 1, dlzka_simulacie);
figure,plot(hody_mincou)
axis([0 100 0 2])