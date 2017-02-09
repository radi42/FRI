format short
t = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108];
f = [97.81 93.995 90.255 110 138.635 147.075 143.88 143 158.23 186.07 202.455 207.43 216.33 181.31 195 208.97 185.91 209.665 193.3 189.265 200.95 238.195 242.405 230.24 250.75 224.725 229.08 235.69 248.955 261.35 255 257.625 283.635 353.5 346.5 345.74 282.15 235.59 220.235 287.145 292.9 263.21 236.875 231.645 200.26 179.68 146.48 153.825 169.265 168.995 174.03 197.985 208.615 210.795 221.525 230.835 247.925 268.06 291.5 309.99 264.97 263.4 283.56 262.85 242.815 222.475 242.425 225.01 262.895 306.85 277.855 296.985 300.18 306.7 293.38 272.05 264.51 253.19 301.845 270.48 257.52 296.32 299.695 322.95 290.055 309.125 320.62 302.425 290.43 290.035 316.485 342.545 377.25 340.15 349.185 353.69 377.845 400.6 397.095 412.285 435.61 440.185 443.875 423.45 437.955 515.29 529.795 555.92 ];


%Polynom 10. stupna
bazaKoeficientuL10 = ones(1,108)
bazaKoeficientuK10 = 1:1:108
bazaKoeficientuJ10 = bazaKoeficientuK10.^2
bazaKoeficientuI10 = bazaKoeficientuK10.^3
bazaKoeficientuH10 = bazaKoeficientuK10.^4
bazaKoeficientuG10 = bazaKoeficientuK10.^5
bazaKoeficientuF10 = bazaKoeficientuK10.^6
bazaKoeficientuE10 = bazaKoeficientuK10.^7
bazaKoeficientuD10 = bazaKoeficientuK10.^8
bazaKoeficientuC10 = bazaKoeficientuK10.^9
bazaKoeficientuB10 = bazaKoeficientuK10.^10
maticaA10 = [
    bazaKoeficientuL10 * bazaKoeficientuL10', bazaKoeficientuK10 * bazaKoeficientuL10', bazaKoeficientuJ10 * bazaKoeficientuL10', bazaKoeficientuI10 * bazaKoeficientuL10', bazaKoeficientuH10 * bazaKoeficientuL10', bazaKoeficientuG10 * bazaKoeficientuL10', bazaKoeficientuF10 * bazaKoeficientuL10', bazaKoeficientuE10 * bazaKoeficientuL10', bazaKoeficientuD10 * bazaKoeficientuL10', bazaKoeficientuC10 * bazaKoeficientuL10', bazaKoeficientuB10 * bazaKoeficientuL10'
    bazaKoeficientuL10 * bazaKoeficientuK10', bazaKoeficientuK10 * bazaKoeficientuK10', bazaKoeficientuJ10 * bazaKoeficientuK10', bazaKoeficientuI10 * bazaKoeficientuK10', bazaKoeficientuH10 * bazaKoeficientuK10', bazaKoeficientuG10 * bazaKoeficientuK10', bazaKoeficientuF10 * bazaKoeficientuK10', bazaKoeficientuE10 * bazaKoeficientuK10', bazaKoeficientuD10 * bazaKoeficientuK10', bazaKoeficientuC10 * bazaKoeficientuK10', bazaKoeficientuB10 * bazaKoeficientuK10'
    bazaKoeficientuL10 * bazaKoeficientuJ10', bazaKoeficientuK10 * bazaKoeficientuJ10', bazaKoeficientuJ10 * bazaKoeficientuJ10', bazaKoeficientuI10 * bazaKoeficientuJ10', bazaKoeficientuH10 * bazaKoeficientuJ10', bazaKoeficientuG10 * bazaKoeficientuJ10', bazaKoeficientuF10 * bazaKoeficientuJ10', bazaKoeficientuE10 * bazaKoeficientuJ10', bazaKoeficientuD10 * bazaKoeficientuJ10', bazaKoeficientuC10 * bazaKoeficientuJ10', bazaKoeficientuB10 * bazaKoeficientuJ10'
    bazaKoeficientuL10 * bazaKoeficientuI10', bazaKoeficientuK10 * bazaKoeficientuI10', bazaKoeficientuJ10 * bazaKoeficientuI10', bazaKoeficientuI10 * bazaKoeficientuI10', bazaKoeficientuH10 * bazaKoeficientuI10', bazaKoeficientuG10 * bazaKoeficientuI10', bazaKoeficientuF10 * bazaKoeficientuI10', bazaKoeficientuE10 * bazaKoeficientuI10', bazaKoeficientuD10 * bazaKoeficientuI10', bazaKoeficientuC10 * bazaKoeficientuI10', bazaKoeficientuB10 * bazaKoeficientuI10'
    bazaKoeficientuL10 * bazaKoeficientuH10', bazaKoeficientuK10 * bazaKoeficientuH10', bazaKoeficientuJ10 * bazaKoeficientuH10', bazaKoeficientuI10 * bazaKoeficientuH10', bazaKoeficientuH10 * bazaKoeficientuH10', bazaKoeficientuG10 * bazaKoeficientuH10', bazaKoeficientuF10 * bazaKoeficientuH10', bazaKoeficientuE10 * bazaKoeficientuH10', bazaKoeficientuD10 * bazaKoeficientuH10', bazaKoeficientuC10 * bazaKoeficientuH10', bazaKoeficientuB10 * bazaKoeficientuH10'
    bazaKoeficientuL10 * bazaKoeficientuG10', bazaKoeficientuK10 * bazaKoeficientuG10', bazaKoeficientuJ10 * bazaKoeficientuG10', bazaKoeficientuI10 * bazaKoeficientuG10', bazaKoeficientuH10 * bazaKoeficientuG10', bazaKoeficientuG10 * bazaKoeficientuG10', bazaKoeficientuF10 * bazaKoeficientuG10', bazaKoeficientuE10 * bazaKoeficientuG10', bazaKoeficientuD10 * bazaKoeficientuG10', bazaKoeficientuC10 * bazaKoeficientuG10', bazaKoeficientuB10 * bazaKoeficientuG10'
    bazaKoeficientuL10 * bazaKoeficientuF10', bazaKoeficientuK10 * bazaKoeficientuF10', bazaKoeficientuJ10 * bazaKoeficientuF10', bazaKoeficientuI10 * bazaKoeficientuF10', bazaKoeficientuH10 * bazaKoeficientuF10', bazaKoeficientuG10 * bazaKoeficientuF10', bazaKoeficientuF10 * bazaKoeficientuF10', bazaKoeficientuE10 * bazaKoeficientuF10', bazaKoeficientuD10 * bazaKoeficientuF10', bazaKoeficientuC10 * bazaKoeficientuF10', bazaKoeficientuB10 * bazaKoeficientuF10'
    bazaKoeficientuL10 * bazaKoeficientuE10', bazaKoeficientuK10 * bazaKoeficientuE10', bazaKoeficientuJ10 * bazaKoeficientuE10', bazaKoeficientuI10 * bazaKoeficientuE10', bazaKoeficientuH10 * bazaKoeficientuE10', bazaKoeficientuG10 * bazaKoeficientuE10', bazaKoeficientuF10 * bazaKoeficientuE10', bazaKoeficientuE10 * bazaKoeficientuE10', bazaKoeficientuD10 * bazaKoeficientuE10', bazaKoeficientuC10 * bazaKoeficientuE10', bazaKoeficientuB10 * bazaKoeficientuE10'
    bazaKoeficientuL10 * bazaKoeficientuD10', bazaKoeficientuK10 * bazaKoeficientuD10', bazaKoeficientuJ10 * bazaKoeficientuD10', bazaKoeficientuI10 * bazaKoeficientuD10', bazaKoeficientuH10 * bazaKoeficientuD10', bazaKoeficientuG10 * bazaKoeficientuD10', bazaKoeficientuF10 * bazaKoeficientuD10', bazaKoeficientuE10 * bazaKoeficientuD10', bazaKoeficientuD10 * bazaKoeficientuD10', bazaKoeficientuC10 * bazaKoeficientuD10', bazaKoeficientuB10 * bazaKoeficientuD10'
    bazaKoeficientuL10 * bazaKoeficientuC10', bazaKoeficientuK10 * bazaKoeficientuC10', bazaKoeficientuJ10 * bazaKoeficientuC10', bazaKoeficientuI10 * bazaKoeficientuC10', bazaKoeficientuH10 * bazaKoeficientuC10', bazaKoeficientuG10 * bazaKoeficientuC10', bazaKoeficientuF10 * bazaKoeficientuC10', bazaKoeficientuE10 * bazaKoeficientuC10', bazaKoeficientuD10 * bazaKoeficientuC10', bazaKoeficientuC10 * bazaKoeficientuC10', bazaKoeficientuB10 * bazaKoeficientuC10'
    bazaKoeficientuL10 * bazaKoeficientuB10', bazaKoeficientuK10 * bazaKoeficientuB10', bazaKoeficientuJ10 * bazaKoeficientuB10', bazaKoeficientuI10 * bazaKoeficientuB10', bazaKoeficientuH10 * bazaKoeficientuB10', bazaKoeficientuG10 * bazaKoeficientuB10', bazaKoeficientuF10 * bazaKoeficientuB10', bazaKoeficientuE10 * bazaKoeficientuB10', bazaKoeficientuD10 * bazaKoeficientuB10', bazaKoeficientuC10 * bazaKoeficientuB10', bazaKoeficientuB10 * bazaKoeficientuB10'
    ]
praveStrany10 = [
    f*bazaKoeficientuL10'
    f*bazaKoeficientuK10'
    f*bazaKoeficientuJ10'
    f*bazaKoeficientuI10'
    f*bazaKoeficientuH10'
    f*bazaKoeficientuG10'
    f*bazaKoeficientuF10'
    f*bazaKoeficientuE10'
    f*bazaKoeficientuD10'
    f*bazaKoeficientuC10'
    f*bazaKoeficientuB10'
    ]
koeficienty10 = linsolve(maticaA10, praveStrany10)
b10 = koeficienty10(11)
c10 = koeficienty10(10)
d10 = koeficienty10(9)
e10 = koeficienty10(8)
f10 = koeficienty10(7)
g10 = koeficienty10(6)
h10 = koeficienty10(5)
i10 = koeficienty10(4)
j10 = koeficienty10(3)
k10 = koeficienty10(2)
l10 = koeficienty10(1)
fProjekciaPolynomStupna10 = b10*t.^10 + c10*t.^9 + d10*t.^8 + e10*t.^7 + f10*t.^6 + g10*t.^5 + h10*t.^4 + i10*t.^3 + j10*t.^2 + k10*t.^1 + l10
chyba10 = abs(f-fProjekciaPolynomStupna10)
energiaRozdielovehoVektora10 = sqrt(sum(chyba10.^2))
vektorChyb(1) = energiaRozdielovehoVektora10









%odstranenie koeficientu h10

bazaKoeficientuL10 = ones(1,108)
bazaKoeficientuK10 = 1:1:108
bazaKoeficientuJ10 = bazaKoeficientuK10.^2
bazaKoeficientuI10 = bazaKoeficientuK10.^3
%bazaKoeficientuH10 = bazaKoeficientuK10.^4
bazaKoeficientuG10 = bazaKoeficientuK10.^5
bazaKoeficientuF10 = bazaKoeficientuK10.^6
bazaKoeficientuE10 = bazaKoeficientuK10.^7
bazaKoeficientuD10 = bazaKoeficientuK10.^8
bazaKoeficientuC10 = bazaKoeficientuK10.^9
bazaKoeficientuB10 = bazaKoeficientuK10.^10
maticaA10 = [
    bazaKoeficientuL10 * bazaKoeficientuL10', bazaKoeficientuK10 * bazaKoeficientuL10', bazaKoeficientuJ10 * bazaKoeficientuL10', bazaKoeficientuI10 * bazaKoeficientuL10', bazaKoeficientuG10 * bazaKoeficientuL10', bazaKoeficientuF10 * bazaKoeficientuL10', bazaKoeficientuE10 * bazaKoeficientuL10', bazaKoeficientuD10 * bazaKoeficientuL10', bazaKoeficientuC10 * bazaKoeficientuL10', bazaKoeficientuB10 * bazaKoeficientuL10'
    bazaKoeficientuL10 * bazaKoeficientuK10', bazaKoeficientuK10 * bazaKoeficientuK10', bazaKoeficientuJ10 * bazaKoeficientuK10', bazaKoeficientuI10 * bazaKoeficientuK10', bazaKoeficientuG10 * bazaKoeficientuK10', bazaKoeficientuF10 * bazaKoeficientuK10', bazaKoeficientuE10 * bazaKoeficientuK10', bazaKoeficientuD10 * bazaKoeficientuK10', bazaKoeficientuC10 * bazaKoeficientuK10', bazaKoeficientuB10 * bazaKoeficientuK10'
    bazaKoeficientuL10 * bazaKoeficientuJ10', bazaKoeficientuK10 * bazaKoeficientuJ10', bazaKoeficientuJ10 * bazaKoeficientuJ10', bazaKoeficientuI10 * bazaKoeficientuJ10', bazaKoeficientuG10 * bazaKoeficientuJ10', bazaKoeficientuF10 * bazaKoeficientuJ10', bazaKoeficientuE10 * bazaKoeficientuJ10', bazaKoeficientuD10 * bazaKoeficientuJ10', bazaKoeficientuC10 * bazaKoeficientuJ10', bazaKoeficientuB10 * bazaKoeficientuJ10'
    bazaKoeficientuL10 * bazaKoeficientuI10', bazaKoeficientuK10 * bazaKoeficientuI10', bazaKoeficientuJ10 * bazaKoeficientuI10', bazaKoeficientuI10 * bazaKoeficientuI10', bazaKoeficientuG10 * bazaKoeficientuI10', bazaKoeficientuF10 * bazaKoeficientuI10', bazaKoeficientuE10 * bazaKoeficientuI10', bazaKoeficientuD10 * bazaKoeficientuI10', bazaKoeficientuC10 * bazaKoeficientuI10', bazaKoeficientuB10 * bazaKoeficientuI10'
    bazaKoeficientuL10 * bazaKoeficientuG10', bazaKoeficientuK10 * bazaKoeficientuG10', bazaKoeficientuJ10 * bazaKoeficientuG10', bazaKoeficientuI10 * bazaKoeficientuG10', bazaKoeficientuG10 * bazaKoeficientuG10', bazaKoeficientuF10 * bazaKoeficientuG10', bazaKoeficientuE10 * bazaKoeficientuG10', bazaKoeficientuD10 * bazaKoeficientuG10', bazaKoeficientuC10 * bazaKoeficientuG10', bazaKoeficientuB10 * bazaKoeficientuG10'
    bazaKoeficientuL10 * bazaKoeficientuF10', bazaKoeficientuK10 * bazaKoeficientuF10', bazaKoeficientuJ10 * bazaKoeficientuF10', bazaKoeficientuI10 * bazaKoeficientuF10', bazaKoeficientuG10 * bazaKoeficientuF10', bazaKoeficientuF10 * bazaKoeficientuF10', bazaKoeficientuE10 * bazaKoeficientuF10', bazaKoeficientuD10 * bazaKoeficientuF10', bazaKoeficientuC10 * bazaKoeficientuF10', bazaKoeficientuB10 * bazaKoeficientuF10'
    bazaKoeficientuL10 * bazaKoeficientuE10', bazaKoeficientuK10 * bazaKoeficientuE10', bazaKoeficientuJ10 * bazaKoeficientuE10', bazaKoeficientuI10 * bazaKoeficientuE10', bazaKoeficientuG10 * bazaKoeficientuE10', bazaKoeficientuF10 * bazaKoeficientuE10', bazaKoeficientuE10 * bazaKoeficientuE10', bazaKoeficientuD10 * bazaKoeficientuE10', bazaKoeficientuC10 * bazaKoeficientuE10', bazaKoeficientuB10 * bazaKoeficientuE10'
    bazaKoeficientuL10 * bazaKoeficientuD10', bazaKoeficientuK10 * bazaKoeficientuD10', bazaKoeficientuJ10 * bazaKoeficientuD10', bazaKoeficientuI10 * bazaKoeficientuD10', bazaKoeficientuG10 * bazaKoeficientuD10', bazaKoeficientuF10 * bazaKoeficientuD10', bazaKoeficientuE10 * bazaKoeficientuD10', bazaKoeficientuD10 * bazaKoeficientuD10', bazaKoeficientuC10 * bazaKoeficientuD10', bazaKoeficientuB10 * bazaKoeficientuD10'
    bazaKoeficientuL10 * bazaKoeficientuC10', bazaKoeficientuK10 * bazaKoeficientuC10', bazaKoeficientuJ10 * bazaKoeficientuC10', bazaKoeficientuI10 * bazaKoeficientuC10', bazaKoeficientuG10 * bazaKoeficientuC10', bazaKoeficientuF10 * bazaKoeficientuC10', bazaKoeficientuE10 * bazaKoeficientuC10', bazaKoeficientuD10 * bazaKoeficientuC10', bazaKoeficientuC10 * bazaKoeficientuC10', bazaKoeficientuB10 * bazaKoeficientuC10'
    bazaKoeficientuL10 * bazaKoeficientuB10', bazaKoeficientuK10 * bazaKoeficientuB10', bazaKoeficientuJ10 * bazaKoeficientuB10', bazaKoeficientuI10 * bazaKoeficientuB10', bazaKoeficientuG10 * bazaKoeficientuB10', bazaKoeficientuF10 * bazaKoeficientuB10', bazaKoeficientuE10 * bazaKoeficientuB10', bazaKoeficientuD10 * bazaKoeficientuB10', bazaKoeficientuC10 * bazaKoeficientuB10', bazaKoeficientuB10 * bazaKoeficientuB10'
    ]
praveStrany10 = [
    f*bazaKoeficientuL10'
    f*bazaKoeficientuK10'
    f*bazaKoeficientuJ10'
    f*bazaKoeficientuI10'
    %f*bazaKoeficientuH10'
    f*bazaKoeficientuG10'
    f*bazaKoeficientuF10'
    f*bazaKoeficientuE10'
    f*bazaKoeficientuD10'
    f*bazaKoeficientuC10'
    f*bazaKoeficientuB10'
    ]
koeficienty10 = linsolve(maticaA10, praveStrany10)
b10 = koeficienty10(10)
c10 = koeficienty10(9)
d10 = koeficienty10(8)
e10 = koeficienty10(7)
f10 = koeficienty10(6)
g10 = koeficienty10(5)
%h10 = koeficienty10(5)
i10 = koeficienty10(4)
j10 = koeficienty10(3)
k10 = koeficienty10(2)
l10 = koeficienty10(1)
h10_vynechany = b10*t.^10 + c10*t.^9 + d10*t.^8 + e10*t.^7 + f10*t.^6 + g10*t.^5 + i10*t.^3 + j10*t.^2 + k10*t.^1 + l10
chyba10 = abs(f-h10_vynechany)
energiaRozdielovehoVektora10_bez_h10 = sqrt(sum(chyba10.^2))
vektorChyb(2) = energiaRozdielovehoVektora10_bez_h10







%odstranenie koeficientu g10

bazaKoeficientuL10 = ones(1,108)
bazaKoeficientuK10 = 1:1:108
bazaKoeficientuJ10 = bazaKoeficientuK10.^2
bazaKoeficientuI10 = bazaKoeficientuK10.^3
%bazaKoeficientuH10 = bazaKoeficientuK10.^4
%bazaKoeficientuG10 = bazaKoeficientuK10.^5
bazaKoeficientuF10 = bazaKoeficientuK10.^6
bazaKoeficientuE10 = bazaKoeficientuK10.^7
bazaKoeficientuD10 = bazaKoeficientuK10.^8
bazaKoeficientuC10 = bazaKoeficientuK10.^9
bazaKoeficientuB10 = bazaKoeficientuK10.^10
maticaA10 = [
    bazaKoeficientuL10 * bazaKoeficientuL10', bazaKoeficientuK10 * bazaKoeficientuL10', bazaKoeficientuJ10 * bazaKoeficientuL10', bazaKoeficientuI10 * bazaKoeficientuL10', bazaKoeficientuF10 * bazaKoeficientuL10', bazaKoeficientuE10 * bazaKoeficientuL10', bazaKoeficientuD10 * bazaKoeficientuL10', bazaKoeficientuC10 * bazaKoeficientuL10', bazaKoeficientuB10 * bazaKoeficientuL10'
    bazaKoeficientuL10 * bazaKoeficientuK10', bazaKoeficientuK10 * bazaKoeficientuK10', bazaKoeficientuJ10 * bazaKoeficientuK10', bazaKoeficientuI10 * bazaKoeficientuK10', bazaKoeficientuF10 * bazaKoeficientuK10', bazaKoeficientuE10 * bazaKoeficientuK10', bazaKoeficientuD10 * bazaKoeficientuK10', bazaKoeficientuC10 * bazaKoeficientuK10', bazaKoeficientuB10 * bazaKoeficientuK10'
    bazaKoeficientuL10 * bazaKoeficientuJ10', bazaKoeficientuK10 * bazaKoeficientuJ10', bazaKoeficientuJ10 * bazaKoeficientuJ10', bazaKoeficientuI10 * bazaKoeficientuJ10', bazaKoeficientuF10 * bazaKoeficientuJ10', bazaKoeficientuE10 * bazaKoeficientuJ10', bazaKoeficientuD10 * bazaKoeficientuJ10', bazaKoeficientuC10 * bazaKoeficientuJ10', bazaKoeficientuB10 * bazaKoeficientuJ10'
    bazaKoeficientuL10 * bazaKoeficientuI10', bazaKoeficientuK10 * bazaKoeficientuI10', bazaKoeficientuJ10 * bazaKoeficientuI10', bazaKoeficientuI10 * bazaKoeficientuI10', bazaKoeficientuF10 * bazaKoeficientuI10', bazaKoeficientuE10 * bazaKoeficientuI10', bazaKoeficientuD10 * bazaKoeficientuI10', bazaKoeficientuC10 * bazaKoeficientuI10', bazaKoeficientuB10 * bazaKoeficientuI10'
    bazaKoeficientuL10 * bazaKoeficientuF10', bazaKoeficientuK10 * bazaKoeficientuF10', bazaKoeficientuJ10 * bazaKoeficientuF10', bazaKoeficientuI10 * bazaKoeficientuF10', bazaKoeficientuF10 * bazaKoeficientuF10', bazaKoeficientuE10 * bazaKoeficientuF10', bazaKoeficientuD10 * bazaKoeficientuF10', bazaKoeficientuC10 * bazaKoeficientuF10', bazaKoeficientuB10 * bazaKoeficientuF10'
    bazaKoeficientuL10 * bazaKoeficientuE10', bazaKoeficientuK10 * bazaKoeficientuE10', bazaKoeficientuJ10 * bazaKoeficientuE10', bazaKoeficientuI10 * bazaKoeficientuE10', bazaKoeficientuF10 * bazaKoeficientuE10', bazaKoeficientuE10 * bazaKoeficientuE10', bazaKoeficientuD10 * bazaKoeficientuE10', bazaKoeficientuC10 * bazaKoeficientuE10', bazaKoeficientuB10 * bazaKoeficientuE10'
    bazaKoeficientuL10 * bazaKoeficientuD10', bazaKoeficientuK10 * bazaKoeficientuD10', bazaKoeficientuJ10 * bazaKoeficientuD10', bazaKoeficientuI10 * bazaKoeficientuD10', bazaKoeficientuF10 * bazaKoeficientuD10', bazaKoeficientuE10 * bazaKoeficientuD10', bazaKoeficientuD10 * bazaKoeficientuD10', bazaKoeficientuC10 * bazaKoeficientuD10', bazaKoeficientuB10 * bazaKoeficientuD10'
    bazaKoeficientuL10 * bazaKoeficientuC10', bazaKoeficientuK10 * bazaKoeficientuC10', bazaKoeficientuJ10 * bazaKoeficientuC10', bazaKoeficientuI10 * bazaKoeficientuC10', bazaKoeficientuF10 * bazaKoeficientuC10', bazaKoeficientuE10 * bazaKoeficientuC10', bazaKoeficientuD10 * bazaKoeficientuC10', bazaKoeficientuC10 * bazaKoeficientuC10', bazaKoeficientuB10 * bazaKoeficientuC10'
    bazaKoeficientuL10 * bazaKoeficientuB10', bazaKoeficientuK10 * bazaKoeficientuB10', bazaKoeficientuJ10 * bazaKoeficientuB10', bazaKoeficientuI10 * bazaKoeficientuB10', bazaKoeficientuF10 * bazaKoeficientuB10', bazaKoeficientuE10 * bazaKoeficientuB10', bazaKoeficientuD10 * bazaKoeficientuB10', bazaKoeficientuC10 * bazaKoeficientuB10', bazaKoeficientuB10 * bazaKoeficientuB10'
    ]
praveStrany10 = [
    f*bazaKoeficientuL10'
    f*bazaKoeficientuK10'
    f*bazaKoeficientuJ10'
    f*bazaKoeficientuI10'
    %f*bazaKoeficientuH10'
    %f*bazaKoeficientuG10'
    f*bazaKoeficientuF10'
    f*bazaKoeficientuE10'
    f*bazaKoeficientuD10'
    f*bazaKoeficientuC10'
    f*bazaKoeficientuB10'
    ]
koeficienty10 = linsolve(maticaA10, praveStrany10)
b10 = koeficienty10(9)
c10 = koeficienty10(8)
d10 = koeficienty10(7)
e10 = koeficienty10(6)
f10 = koeficienty10(5)
%g10 = koeficienty10(5)
%h10 = koeficienty10(5)
i10 = koeficienty10(4)
j10 = koeficienty10(3)
k10 = koeficienty10(2)
l10 = koeficienty10(1)
h10_g10_vynechane = b10*t.^10 + c10*t.^9 + d10*t.^8 + e10*t.^7 + f10*t.^6 + i10*t.^3 + j10*t.^2 + k10*t.^1 + l10
chyba10 = abs(f-h10_g10_vynechane)
energiaRozdielovehoVektora10_bez_h10_a_g10 = sqrt(sum(chyba10.^2))
vektorChyb(3) = energiaRozdielovehoVektora10_bez_h10_a_g10







%odstranenie koeficientu f10

bazaKoeficientuL10 = ones(1,108)
bazaKoeficientuK10 = 1:1:108
bazaKoeficientuJ10 = bazaKoeficientuK10.^2
bazaKoeficientuI10 = bazaKoeficientuK10.^3
%bazaKoeficientuH10 = bazaKoeficientuK10.^4
%bazaKoeficientuG10 = bazaKoeficientuK10.^5
%bazaKoeficientuF10 = bazaKoeficientuK10.^6
bazaKoeficientuE10 = bazaKoeficientuK10.^7
bazaKoeficientuD10 = bazaKoeficientuK10.^8
bazaKoeficientuC10 = bazaKoeficientuK10.^9
bazaKoeficientuB10 = bazaKoeficientuK10.^10
maticaA10 = [
    bazaKoeficientuL10 * bazaKoeficientuL10', bazaKoeficientuK10 * bazaKoeficientuL10', bazaKoeficientuJ10 * bazaKoeficientuL10', bazaKoeficientuI10 * bazaKoeficientuL10', bazaKoeficientuE10 * bazaKoeficientuL10', bazaKoeficientuD10 * bazaKoeficientuL10', bazaKoeficientuC10 * bazaKoeficientuL10', bazaKoeficientuB10 * bazaKoeficientuL10'
    bazaKoeficientuL10 * bazaKoeficientuK10', bazaKoeficientuK10 * bazaKoeficientuK10', bazaKoeficientuJ10 * bazaKoeficientuK10', bazaKoeficientuI10 * bazaKoeficientuK10', bazaKoeficientuE10 * bazaKoeficientuK10', bazaKoeficientuD10 * bazaKoeficientuK10', bazaKoeficientuC10 * bazaKoeficientuK10', bazaKoeficientuB10 * bazaKoeficientuK10'
    bazaKoeficientuL10 * bazaKoeficientuJ10', bazaKoeficientuK10 * bazaKoeficientuJ10', bazaKoeficientuJ10 * bazaKoeficientuJ10', bazaKoeficientuI10 * bazaKoeficientuJ10', bazaKoeficientuE10 * bazaKoeficientuJ10', bazaKoeficientuD10 * bazaKoeficientuJ10', bazaKoeficientuC10 * bazaKoeficientuJ10', bazaKoeficientuB10 * bazaKoeficientuJ10'
    bazaKoeficientuL10 * bazaKoeficientuI10', bazaKoeficientuK10 * bazaKoeficientuI10', bazaKoeficientuJ10 * bazaKoeficientuI10', bazaKoeficientuI10 * bazaKoeficientuI10', bazaKoeficientuE10 * bazaKoeficientuI10', bazaKoeficientuD10 * bazaKoeficientuI10', bazaKoeficientuC10 * bazaKoeficientuI10', bazaKoeficientuB10 * bazaKoeficientuI10'
    bazaKoeficientuL10 * bazaKoeficientuE10', bazaKoeficientuK10 * bazaKoeficientuE10', bazaKoeficientuJ10 * bazaKoeficientuE10', bazaKoeficientuI10 * bazaKoeficientuE10', bazaKoeficientuE10 * bazaKoeficientuE10', bazaKoeficientuD10 * bazaKoeficientuE10', bazaKoeficientuC10 * bazaKoeficientuE10', bazaKoeficientuB10 * bazaKoeficientuE10'
    bazaKoeficientuL10 * bazaKoeficientuD10', bazaKoeficientuK10 * bazaKoeficientuD10', bazaKoeficientuJ10 * bazaKoeficientuD10', bazaKoeficientuI10 * bazaKoeficientuD10', bazaKoeficientuE10 * bazaKoeficientuD10', bazaKoeficientuD10 * bazaKoeficientuD10', bazaKoeficientuC10 * bazaKoeficientuD10', bazaKoeficientuB10 * bazaKoeficientuD10'
    bazaKoeficientuL10 * bazaKoeficientuC10', bazaKoeficientuK10 * bazaKoeficientuC10', bazaKoeficientuJ10 * bazaKoeficientuC10', bazaKoeficientuI10 * bazaKoeficientuC10', bazaKoeficientuE10 * bazaKoeficientuC10', bazaKoeficientuD10 * bazaKoeficientuC10', bazaKoeficientuC10 * bazaKoeficientuC10', bazaKoeficientuB10 * bazaKoeficientuC10'
    bazaKoeficientuL10 * bazaKoeficientuB10', bazaKoeficientuK10 * bazaKoeficientuB10', bazaKoeficientuJ10 * bazaKoeficientuB10', bazaKoeficientuI10 * bazaKoeficientuB10', bazaKoeficientuE10 * bazaKoeficientuB10', bazaKoeficientuD10 * bazaKoeficientuB10', bazaKoeficientuC10 * bazaKoeficientuB10', bazaKoeficientuB10 * bazaKoeficientuB10'
    ]
praveStrany10 = [
    f*bazaKoeficientuL10'
    f*bazaKoeficientuK10'
    f*bazaKoeficientuJ10'
    f*bazaKoeficientuI10'
    %f*bazaKoeficientuH10'
    %f*bazaKoeficientuG10'
    %f*bazaKoeficientuF10'
    f*bazaKoeficientuE10'
    f*bazaKoeficientuD10'
    f*bazaKoeficientuC10'
    f*bazaKoeficientuB10'
    ]
koeficienty10 = linsolve(maticaA10, praveStrany10)
b10 = koeficienty10(8)
c10 = koeficienty10(7)
d10 = koeficienty10(6)
e10 = koeficienty10(5)
%f10 = koeficienty10(5)
%g10 = koeficienty10(5)
%h10 = koeficienty10(5)
i10 = koeficienty10(4)
j10 = koeficienty10(3)
k10 = koeficienty10(2)
l10 = koeficienty10(1)
h10_g10_f10_vynechane = b10*t.^10 + c10*t.^9 + d10*t.^8 + e10*t.^7 + i10*t.^3 + j10*t.^2 + k10*t.^1 + l10
chyba10 = abs(f-h10_g10_f10_vynechane)
energiaRozdielovehoVektora10_bez_h10_a_g10_a_f10 = sqrt(sum(chyba10.^2))
vektorChyb(4) = energiaRozdielovehoVektora10_bez_h10_a_g10_a_f10







%vyhodnotenie + ploty
vektorChyb

plot(t, f, t, fProjekciaPolynomStupna10, t, h10_vynechany, t, h10_g10_vynechane, '-')


  
grid on
xlabel('Rok')
ylabel('Cena akcií (v USD)')
ax = gca;
ax.XTick = [1, 1+12, 1+12*2, 1+12*3, 1+12*4, 1+12*5, 1+12*6 1+12*7, 1+12*8, 12*9]
ax.XTickLabel = {'1/2005', '1/2006', '1/2007', '1/2008', '1/2009', '1/2010', '1/2011', '1/2012', '1/2013', '12/2013'}