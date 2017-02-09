format short
t = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108]
f = [97.81 93.995 90.255 110 138.635 147.075 143.88 143 158.23 186.07 202.455 207.43 216.33 181.31 195 208.97 185.91 209.665 193.3 189.265 200.95 238.195 242.405 230.24 250.75 224.725 229.08 235.69 248.955 261.35 255 257.625 283.635 353.5 346.5 345.74 282.15 235.59 220.235 287.145 292.9 263.21 236.875 231.645 200.26 179.68 146.48 153.825 169.265 168.995 174.03 197.985 208.615 210.795 221.525 230.835 247.925 268.06 291.5 309.99 264.97 263.4 283.56 262.85 242.815 222.475 242.425 225.01 262.895 306.85 277.855 296.985 300.18 306.7 293.38 272.05 264.51 253.19 301.845 270.48 257.52 296.32 299.695 322.95 290.055 309.125 320.62 302.425 290.43 290.035 316.485 342.545 377.25 340.15 349.185 353.69 377.845 400.6 397.095 412.285 435.61 440.185 443.875 423.45 437.955 515.29 529.795 555.92 ]


%projekcia priamkou a*t
a1 =(f*t')/(t*t')
fProjekciaPriamkou = a1 * t
chyba1 = abs(f-fProjekciaPriamkou)
energiaRozdielovehoVektora1 = sqrt(sum(chyba1.^2))
priemernaChyba1 = energiaRozdielovehoVektora1 / length(t)
vektorPriemernychChyb(1) = priemernaChyba1


%projekcia parabolou a*t^2
tNaDruhu = t.^2
a2 = (f*tNaDruhu') / (tNaDruhu*tNaDruhu')
fProjekciaParabolou = a2 * tNaDruhu
chyba2 = abs(f-fProjekciaParabolou)
energiaRozdielovehoVektora2 = sqrt(sum(chyba2.^2))
priemernaChyba2 = energiaRozdielovehoVektora2 / length(t)
vektorPriemernychChyb(2) = priemernaChyba2



%projekcia priamkou s dvomi parametrami: a*t + b
bazaKoeficientuB3 = ones(1,108)
bazaKoeficientuA3 = 1:1:108
maticaA = [bazaKoeficientuB3 * bazaKoeficientuB3', bazaKoeficientuA3 * bazaKoeficientuB3'
    bazaKoeficientuB3 * bazaKoeficientuA3', bazaKoeficientuA3 * bazaKoeficientuA3']
praveStrany = [ f*bazaKoeficientuB3'
    f*bazaKoeficientuA3']
koeficienty = linsolve(maticaA, praveStrany)
a3 = koeficienty(2)
b3 = koeficienty(1)
fProjekciaPriamkouDvaParametre = a3 * t + b3
chyba3 = abs(f-fProjekciaPriamkouDvaParametre)
energiaRozdielovehoVektora3 = sqrt(sum(chyba3.^2))
priemernaChyba3 = energiaRozdielovehoVektora3 / length(t)
vektorPriemernychChyb(3) = priemernaChyba3

%polynom 2. stupna
bazaKoeficientuC4 = ones(1,108)
bazaKoeficientuB4 = 1:1:108
bazaKoeficientuA4 = bazaKoeficientuB4.^2
maticaA4 = [bazaKoeficientuC4 * bazaKoeficientuC4', bazaKoeficientuB4 * bazaKoeficientuC4', bazaKoeficientuA4 * bazaKoeficientuC4'
    bazaKoeficientuC4 * bazaKoeficientuB4', bazaKoeficientuB4 * bazaKoeficientuB4', bazaKoeficientuA4 * bazaKoeficientuB4'
    bazaKoeficientuC4 * bazaKoeficientuA4', bazaKoeficientuB4 * bazaKoeficientuA4', bazaKoeficientuA4 * bazaKoeficientuA4']
praveStrany4 = [f*bazaKoeficientuC4'
    f*bazaKoeficientuB4'
    f*bazaKoeficientuA4']
koeficienty4 = linsolve(maticaA4, praveStrany4)
a4 = koeficienty4(3)
b4 = koeficienty4(2)
c4 = koeficienty4(1)
fProjekciaParabolouTriParametre = a4*t.^2+b4*t+c4
chyba4 = abs(f-fProjekciaParabolouTriParametre)
energiaRozdielovehoVektora4 = sqrt(sum(chyba4.^2))
priemernaChyba4 = energiaRozdielovehoVektora4 / length(t)
vektorPriemernychChyb(4) = priemernaChyba4



%polynom 3. stupna
bazaKoeficientuD5 = ones(1,108)
bazaKoeficientuC5 = 1:1:108
bazaKoeficientuB5 = bazaKoeficientuC5.^2
bazaKoeficientuA5 = bazaKoeficientuC5.^3
maticaA5 = [bazaKoeficientuD5 * bazaKoeficientuD5', bazaKoeficientuC5 * bazaKoeficientuD5', bazaKoeficientuB5 * bazaKoeficientuD5', bazaKoeficientuA5 * bazaKoeficientuD5'
    bazaKoeficientuD5 * bazaKoeficientuC5', bazaKoeficientuC5 * bazaKoeficientuC5', bazaKoeficientuB5 * bazaKoeficientuC5', bazaKoeficientuA5 * bazaKoeficientuC5'
    bazaKoeficientuD5 * bazaKoeficientuB5', bazaKoeficientuC5 * bazaKoeficientuB5', bazaKoeficientuB5 * bazaKoeficientuB5', bazaKoeficientuA5 * bazaKoeficientuB5'
    bazaKoeficientuD5 * bazaKoeficientuA5', bazaKoeficientuC5 * bazaKoeficientuA5', bazaKoeficientuB5 * bazaKoeficientuA5', bazaKoeficientuA5 * bazaKoeficientuA5']
praveStrany5 = [f*bazaKoeficientuD5'
    f*bazaKoeficientuC5'
    f*bazaKoeficientuB5'
    f*bazaKoeficientuA5']
koeficienty5 = linsolve(maticaA5, praveStrany5)
a5 = koeficienty5(4)
b5 = koeficienty5(3)
c5 = koeficienty5(2)
d5 = koeficienty5(1)
fProjekciaPolynomomTretiehoStupnaStyriParametre= a5*t.^3 + b5*t.^2 + c5*t + d5
chyba5 = abs(f-fProjekciaPolynomomTretiehoStupnaStyriParametre)
energiaRozdielovehoVektora5 = sqrt(sum(chyba5.^2))
priemernaChyba5 = energiaRozdielovehoVektora5 / length(t)
vektorPriemernychChyb(5) = priemernaChyba5




%polynom 4. stupna
bazaKoeficientuE6 = ones(1,108)
bazaKoeficientuD6 = 1:1:108
bazaKoeficientuC6 = bazaKoeficientuD6.^2
bazaKoeficientuB6 = bazaKoeficientuD6.^3
bazaKoeficientuA6 = bazaKoeficientuD6.^4
maticaA6 = [
    bazaKoeficientuE6 * bazaKoeficientuE6', bazaKoeficientuD6 * bazaKoeficientuE6', bazaKoeficientuC6 * bazaKoeficientuE6', bazaKoeficientuB6 * bazaKoeficientuE6', bazaKoeficientuA6 * bazaKoeficientuE6'
    bazaKoeficientuE6 * bazaKoeficientuD6', bazaKoeficientuD6 * bazaKoeficientuD6', bazaKoeficientuC6 * bazaKoeficientuD6', bazaKoeficientuB6 * bazaKoeficientuD6', bazaKoeficientuA6 * bazaKoeficientuD6'
    bazaKoeficientuE6 * bazaKoeficientuC6', bazaKoeficientuD6 * bazaKoeficientuC6', bazaKoeficientuC6 * bazaKoeficientuC6', bazaKoeficientuB6 * bazaKoeficientuC6', bazaKoeficientuA6 * bazaKoeficientuC6'
    bazaKoeficientuE6 * bazaKoeficientuB6', bazaKoeficientuD6 * bazaKoeficientuB6', bazaKoeficientuC6 * bazaKoeficientuB6', bazaKoeficientuB6 * bazaKoeficientuB6', bazaKoeficientuA6 * bazaKoeficientuB6'
    bazaKoeficientuE6 * bazaKoeficientuA6', bazaKoeficientuD6 * bazaKoeficientuA6', bazaKoeficientuC6 * bazaKoeficientuA6', bazaKoeficientuB6 * bazaKoeficientuA6', bazaKoeficientuA6 * bazaKoeficientuA6']
praveStrany6 = [
    f*bazaKoeficientuE6'
    f*bazaKoeficientuD6'
    f*bazaKoeficientuC6'
    f*bazaKoeficientuB6'
    f*bazaKoeficientuA6']
koeficienty6 = linsolve(maticaA6, praveStrany6)
a6 = koeficienty6(5)
b6 = koeficienty6(4)
c6 = koeficienty6(3)
d6 = koeficienty6(2)
e6 = koeficienty6(1)
fProjekciaPolynomomStvrtehoStupnaPatParametrov= a6*t.^4 + b6*t.^3 + c6*t.^2 + d6*t + e6
chyba6 = abs(f-fProjekciaPolynomomStvrtehoStupnaPatParametrov)
energiaRozdielovehoVektora6 = sqrt(sum(chyba6.^2))
priemernaChyba6 = energiaRozdielovehoVektora6 / length(t)
vektorPriemernychChyb(6) = priemernaChyba6


%polynom 5. stupna
bazaKoeficientuF8 = ones(1,108)
bazaKoeficientuE8 = 1:1:108
bazaKoeficientuD8 = bazaKoeficientuE8.^2
bazaKoeficientuC8 = bazaKoeficientuE8.^3
bazaKoeficientuB8 = bazaKoeficientuE8.^4
bazaKoeficientuA8 = bazaKoeficientuE8.^5
maticaA8 = [
    bazaKoeficientuF8 * bazaKoeficientuF8', bazaKoeficientuE8 * bazaKoeficientuF8', bazaKoeficientuD8 * bazaKoeficientuF8', bazaKoeficientuC8 * bazaKoeficientuF8', bazaKoeficientuB8 * bazaKoeficientuF8', bazaKoeficientuA8 * bazaKoeficientuF8'
    bazaKoeficientuF8 * bazaKoeficientuE8', bazaKoeficientuE8 * bazaKoeficientuE8', bazaKoeficientuD8 * bazaKoeficientuE8', bazaKoeficientuC8 * bazaKoeficientuE8', bazaKoeficientuB8 * bazaKoeficientuE8', bazaKoeficientuA8 * bazaKoeficientuE8'
    bazaKoeficientuF8 * bazaKoeficientuD8', bazaKoeficientuE8 * bazaKoeficientuD8', bazaKoeficientuD8 * bazaKoeficientuD8', bazaKoeficientuC8 * bazaKoeficientuD8', bazaKoeficientuB8 * bazaKoeficientuD8', bazaKoeficientuA8 * bazaKoeficientuD8'
    bazaKoeficientuF8 * bazaKoeficientuC8', bazaKoeficientuE8 * bazaKoeficientuC8', bazaKoeficientuD8 * bazaKoeficientuC8', bazaKoeficientuC8 * bazaKoeficientuC8', bazaKoeficientuB8 * bazaKoeficientuC8', bazaKoeficientuA8 * bazaKoeficientuC8'
    bazaKoeficientuF8 * bazaKoeficientuB8', bazaKoeficientuE8 * bazaKoeficientuB8', bazaKoeficientuD8 * bazaKoeficientuB8', bazaKoeficientuC8 * bazaKoeficientuB8', bazaKoeficientuB8 * bazaKoeficientuB8', bazaKoeficientuA8 * bazaKoeficientuB8'
    bazaKoeficientuF8 * bazaKoeficientuA8', bazaKoeficientuE8 * bazaKoeficientuA8', bazaKoeficientuD8 * bazaKoeficientuA8', bazaKoeficientuC8 * bazaKoeficientuA8', bazaKoeficientuB8 * bazaKoeficientuA8', bazaKoeficientuA8 * bazaKoeficientuA8'
    ]
praveStrany8 = [
    f*bazaKoeficientuF8'
    f*bazaKoeficientuE8'
    f*bazaKoeficientuD8'
    f*bazaKoeficientuC8'
    f*bazaKoeficientuB8'
    f*bazaKoeficientuA8']
koeficienty8 = linsolve(maticaA8, praveStrany8)
a8 = koeficienty8(6)
b8 = koeficienty8(5)
c8 = koeficienty8(4)
d8 = koeficienty8(3)
e8 = koeficienty8(2)
f8 = koeficienty8(1)
fProjekciaPolynomomPiatehoStupna = a8*t.^5 + b8*t.^4 + c8*t.^3 + d8*t.^2 + e8*t + f8
chyba8 = abs(f-fProjekciaPolynomomPiatehoStupna)
energiaRozdielovehoVektora8 = sqrt(sum(chyba8.^2))
priemernaChyba8 = energiaRozdielovehoVektora8 / length(t)
vektorPriemernychChyb(7) = priemernaChyba8




%polynom 6. stupna
bazaKoeficientuL9 = ones(1,108)
bazaKoeficientuK9 = 1:1:108
bazaKoeficientuJ9 = bazaKoeficientuK9.^2
bazaKoeficientuI9 = bazaKoeficientuK9.^3
bazaKoeficientuH9 = bazaKoeficientuK9.^4
bazaKoeficientuG9 = bazaKoeficientuK9.^5
bazaKoeficientuF9 = bazaKoeficientuK9.^6
maticaA9 = [
    bazaKoeficientuL9 * bazaKoeficientuL9', bazaKoeficientuK9 * bazaKoeficientuL9', bazaKoeficientuJ9 * bazaKoeficientuL9', bazaKoeficientuI9 * bazaKoeficientuL9', bazaKoeficientuH9 * bazaKoeficientuL9', bazaKoeficientuG9 * bazaKoeficientuL9', bazaKoeficientuF9 * bazaKoeficientuL9'
    bazaKoeficientuL9 * bazaKoeficientuK9', bazaKoeficientuK9 * bazaKoeficientuK9', bazaKoeficientuJ9 * bazaKoeficientuK9', bazaKoeficientuI9 * bazaKoeficientuK9', bazaKoeficientuH9 * bazaKoeficientuK9', bazaKoeficientuG9 * bazaKoeficientuK9', bazaKoeficientuF9 * bazaKoeficientuK9'
    bazaKoeficientuL9 * bazaKoeficientuJ9', bazaKoeficientuK9 * bazaKoeficientuJ9', bazaKoeficientuJ9 * bazaKoeficientuJ9', bazaKoeficientuI9 * bazaKoeficientuJ9', bazaKoeficientuH9 * bazaKoeficientuJ9', bazaKoeficientuG9 * bazaKoeficientuJ9', bazaKoeficientuF9 * bazaKoeficientuJ9'
    bazaKoeficientuL9 * bazaKoeficientuI9', bazaKoeficientuK9 * bazaKoeficientuI9', bazaKoeficientuJ9 * bazaKoeficientuI9', bazaKoeficientuI9 * bazaKoeficientuI9', bazaKoeficientuH9 * bazaKoeficientuI9', bazaKoeficientuG9 * bazaKoeficientuI9', bazaKoeficientuF9 * bazaKoeficientuI9'
    bazaKoeficientuL9 * bazaKoeficientuH9', bazaKoeficientuK9 * bazaKoeficientuH9', bazaKoeficientuJ9 * bazaKoeficientuH9', bazaKoeficientuI9 * bazaKoeficientuH9', bazaKoeficientuH9 * bazaKoeficientuH9', bazaKoeficientuG9 * bazaKoeficientuH9', bazaKoeficientuF9 * bazaKoeficientuH9'
    bazaKoeficientuL9 * bazaKoeficientuG9', bazaKoeficientuK9 * bazaKoeficientuG9', bazaKoeficientuJ9 * bazaKoeficientuG9', bazaKoeficientuI9 * bazaKoeficientuG9', bazaKoeficientuH9 * bazaKoeficientuG9', bazaKoeficientuG9 * bazaKoeficientuG9', bazaKoeficientuF9 * bazaKoeficientuG9'
    bazaKoeficientuL9 * bazaKoeficientuF9', bazaKoeficientuK9 * bazaKoeficientuF9', bazaKoeficientuJ9 * bazaKoeficientuF9', bazaKoeficientuI9 * bazaKoeficientuF9', bazaKoeficientuH9 * bazaKoeficientuF9', bazaKoeficientuG9 * bazaKoeficientuF9', bazaKoeficientuF9 * bazaKoeficientuF9'
    ]
praveStrany9 = [
    f*bazaKoeficientuL9'
    f*bazaKoeficientuK9'
    f*bazaKoeficientuJ9'
    f*bazaKoeficientuI9'
    f*bazaKoeficientuH9'
    f*bazaKoeficientuG9'
    f*bazaKoeficientuF9']
koeficienty9 = linsolve(maticaA9, praveStrany9)
f9 = koeficienty9(7)
g9 = koeficienty9(6)
h9 = koeficienty9(5)
i9 = koeficienty9(4)
j9 = koeficienty9(3)
k9 = koeficienty9(2)
l9 = koeficienty9(1)
fProjekciaPolynomomSiestehoStupna = f9*t.^6 + g9*t.^5 + h9*t.^4 + i9*t.^3 + j9*t.^2 + k9*t.^1 + l9
chyba9 = abs(f-fProjekciaPolynomomSiestehoStupna)
energiaRozdielovehoVektora9 = sqrt(sum(chyba9.^2))
priemernaChyba9 = energiaRozdielovehoVektora9 / length(t)
vektorPriemernychChyb(8) = priemernaChyba9




%polynom 11. stupna
bazaKoeficientuL7 = ones(1,108)
bazaKoeficientuK7 = 1:1:108
bazaKoeficientuJ7 = bazaKoeficientuK7.^2
bazaKoeficientuI7 = bazaKoeficientuK7.^3
bazaKoeficientuH7 = bazaKoeficientuK7.^4
bazaKoeficientuG7 = bazaKoeficientuK7.^5
bazaKoeficientuF7 = bazaKoeficientuK7.^6
bazaKoeficientuE7 = bazaKoeficientuK7.^7
bazaKoeficientuD7 = bazaKoeficientuK7.^8
bazaKoeficientuC7 = bazaKoeficientuK7.^9
bazaKoeficientuB7 = bazaKoeficientuK7.^10
bazaKoeficientuA7 = bazaKoeficientuK7.^11
maticaA7 = [
    bazaKoeficientuL7 * bazaKoeficientuL7', bazaKoeficientuK7 * bazaKoeficientuL7', bazaKoeficientuJ7 * bazaKoeficientuL7', bazaKoeficientuI7 * bazaKoeficientuL7', bazaKoeficientuH7 * bazaKoeficientuL7', bazaKoeficientuG7 * bazaKoeficientuL7', bazaKoeficientuF7 * bazaKoeficientuL7', bazaKoeficientuE7 * bazaKoeficientuL7', bazaKoeficientuD7 * bazaKoeficientuL7', bazaKoeficientuC7 * bazaKoeficientuL7', bazaKoeficientuB7 * bazaKoeficientuL7', bazaKoeficientuA7 * bazaKoeficientuL7'
    bazaKoeficientuL7 * bazaKoeficientuK7', bazaKoeficientuK7 * bazaKoeficientuK7', bazaKoeficientuJ7 * bazaKoeficientuK7', bazaKoeficientuI7 * bazaKoeficientuK7', bazaKoeficientuH7 * bazaKoeficientuK7', bazaKoeficientuG7 * bazaKoeficientuK7', bazaKoeficientuF7 * bazaKoeficientuK7', bazaKoeficientuE7 * bazaKoeficientuK7', bazaKoeficientuD7 * bazaKoeficientuK7', bazaKoeficientuC7 * bazaKoeficientuK7', bazaKoeficientuB7 * bazaKoeficientuK7', bazaKoeficientuA7 * bazaKoeficientuK7'
    bazaKoeficientuL7 * bazaKoeficientuJ7', bazaKoeficientuK7 * bazaKoeficientuJ7', bazaKoeficientuJ7 * bazaKoeficientuJ7', bazaKoeficientuI7 * bazaKoeficientuJ7', bazaKoeficientuH7 * bazaKoeficientuJ7', bazaKoeficientuG7 * bazaKoeficientuJ7', bazaKoeficientuF7 * bazaKoeficientuJ7', bazaKoeficientuE7 * bazaKoeficientuJ7', bazaKoeficientuD7 * bazaKoeficientuJ7', bazaKoeficientuC7 * bazaKoeficientuJ7', bazaKoeficientuB7 * bazaKoeficientuJ7', bazaKoeficientuA7 * bazaKoeficientuJ7'
    bazaKoeficientuL7 * bazaKoeficientuI7', bazaKoeficientuK7 * bazaKoeficientuI7', bazaKoeficientuJ7 * bazaKoeficientuI7', bazaKoeficientuI7 * bazaKoeficientuI7', bazaKoeficientuH7 * bazaKoeficientuI7', bazaKoeficientuG7 * bazaKoeficientuI7', bazaKoeficientuF7 * bazaKoeficientuI7', bazaKoeficientuE7 * bazaKoeficientuI7', bazaKoeficientuD7 * bazaKoeficientuI7', bazaKoeficientuC7 * bazaKoeficientuI7', bazaKoeficientuB7 * bazaKoeficientuI7', bazaKoeficientuA7 * bazaKoeficientuI7'
    bazaKoeficientuL7 * bazaKoeficientuH7', bazaKoeficientuK7 * bazaKoeficientuH7', bazaKoeficientuJ7 * bazaKoeficientuH7', bazaKoeficientuI7 * bazaKoeficientuH7', bazaKoeficientuH7 * bazaKoeficientuH7', bazaKoeficientuG7 * bazaKoeficientuH7', bazaKoeficientuF7 * bazaKoeficientuH7', bazaKoeficientuE7 * bazaKoeficientuH7', bazaKoeficientuD7 * bazaKoeficientuH7', bazaKoeficientuC7 * bazaKoeficientuH7', bazaKoeficientuB7 * bazaKoeficientuH7', bazaKoeficientuA7 * bazaKoeficientuH7'
    bazaKoeficientuL7 * bazaKoeficientuG7', bazaKoeficientuK7 * bazaKoeficientuG7', bazaKoeficientuJ7 * bazaKoeficientuG7', bazaKoeficientuI7 * bazaKoeficientuG7', bazaKoeficientuH7 * bazaKoeficientuG7', bazaKoeficientuG7 * bazaKoeficientuG7', bazaKoeficientuF7 * bazaKoeficientuG7', bazaKoeficientuE7 * bazaKoeficientuG7', bazaKoeficientuD7 * bazaKoeficientuG7', bazaKoeficientuC7 * bazaKoeficientuG7', bazaKoeficientuB7 * bazaKoeficientuG7', bazaKoeficientuA7 * bazaKoeficientuG7'
    bazaKoeficientuL7 * bazaKoeficientuF7', bazaKoeficientuK7 * bazaKoeficientuF7', bazaKoeficientuJ7 * bazaKoeficientuF7', bazaKoeficientuI7 * bazaKoeficientuF7', bazaKoeficientuH7 * bazaKoeficientuF7', bazaKoeficientuG7 * bazaKoeficientuF7', bazaKoeficientuF7 * bazaKoeficientuF7', bazaKoeficientuE7 * bazaKoeficientuF7', bazaKoeficientuD7 * bazaKoeficientuF7', bazaKoeficientuC7 * bazaKoeficientuF7', bazaKoeficientuB7 * bazaKoeficientuF7', bazaKoeficientuA7 * bazaKoeficientuF7'
    bazaKoeficientuL7 * bazaKoeficientuE7', bazaKoeficientuK7 * bazaKoeficientuE7', bazaKoeficientuJ7 * bazaKoeficientuE7', bazaKoeficientuI7 * bazaKoeficientuE7', bazaKoeficientuH7 * bazaKoeficientuE7', bazaKoeficientuG7 * bazaKoeficientuE7', bazaKoeficientuF7 * bazaKoeficientuE7', bazaKoeficientuE7 * bazaKoeficientuE7', bazaKoeficientuD7 * bazaKoeficientuE7', bazaKoeficientuC7 * bazaKoeficientuE7', bazaKoeficientuB7 * bazaKoeficientuE7', bazaKoeficientuA7 * bazaKoeficientuE7'
    bazaKoeficientuL7 * bazaKoeficientuD7', bazaKoeficientuK7 * bazaKoeficientuD7', bazaKoeficientuJ7 * bazaKoeficientuD7', bazaKoeficientuI7 * bazaKoeficientuD7', bazaKoeficientuH7 * bazaKoeficientuD7', bazaKoeficientuG7 * bazaKoeficientuD7', bazaKoeficientuF7 * bazaKoeficientuD7', bazaKoeficientuE7 * bazaKoeficientuD7', bazaKoeficientuD7 * bazaKoeficientuD7', bazaKoeficientuC7 * bazaKoeficientuD7', bazaKoeficientuB7 * bazaKoeficientuD7', bazaKoeficientuA7 * bazaKoeficientuD7'
    bazaKoeficientuL7 * bazaKoeficientuC7', bazaKoeficientuK7 * bazaKoeficientuC7', bazaKoeficientuJ7 * bazaKoeficientuC7', bazaKoeficientuI7 * bazaKoeficientuC7', bazaKoeficientuH7 * bazaKoeficientuC7', bazaKoeficientuG7 * bazaKoeficientuC7', bazaKoeficientuF7 * bazaKoeficientuC7', bazaKoeficientuE7 * bazaKoeficientuC7', bazaKoeficientuD7 * bazaKoeficientuC7', bazaKoeficientuC7 * bazaKoeficientuC7', bazaKoeficientuB7 * bazaKoeficientuC7', bazaKoeficientuA7 * bazaKoeficientuC7'
    bazaKoeficientuL7 * bazaKoeficientuB7', bazaKoeficientuK7 * bazaKoeficientuB7', bazaKoeficientuJ7 * bazaKoeficientuB7', bazaKoeficientuI7 * bazaKoeficientuB7', bazaKoeficientuH7 * bazaKoeficientuB7', bazaKoeficientuG7 * bazaKoeficientuB7', bazaKoeficientuF7 * bazaKoeficientuB7', bazaKoeficientuE7 * bazaKoeficientuB7', bazaKoeficientuD7 * bazaKoeficientuB7', bazaKoeficientuC7 * bazaKoeficientuB7', bazaKoeficientuB7 * bazaKoeficientuB7', bazaKoeficientuA7 * bazaKoeficientuB7'
    bazaKoeficientuL7 * bazaKoeficientuA7', bazaKoeficientuK7 * bazaKoeficientuA7', bazaKoeficientuJ7 * bazaKoeficientuA7', bazaKoeficientuI7 * bazaKoeficientuA7', bazaKoeficientuH7 * bazaKoeficientuA7', bazaKoeficientuG7 * bazaKoeficientuA7', bazaKoeficientuF7 * bazaKoeficientuA7', bazaKoeficientuE7 * bazaKoeficientuA7', bazaKoeficientuD7 * bazaKoeficientuA7', bazaKoeficientuC7 * bazaKoeficientuA7', bazaKoeficientuB7 * bazaKoeficientuA7', bazaKoeficientuA7 * bazaKoeficientuA7'
    ]
praveStrany7 = [
    f*bazaKoeficientuL7'
    f*bazaKoeficientuK7'
    f*bazaKoeficientuJ7'
    f*bazaKoeficientuI7'
    f*bazaKoeficientuH7'
    f*bazaKoeficientuG7'
    f*bazaKoeficientuF7'
    f*bazaKoeficientuE7'
    f*bazaKoeficientuD7'
    f*bazaKoeficientuC7'
    f*bazaKoeficientuB7'
    f*bazaKoeficientuA7']
koeficienty7 = linsolve(maticaA7, praveStrany7)
a7 = koeficienty7(12)
b7 = koeficienty7(11)
c7 = koeficienty7(10)
d7 = koeficienty7(9)
e7 = koeficienty7(8)
f7 = koeficienty7(7)
g7 = koeficienty7(6)
h7 = koeficienty7(5)
i7 = koeficienty7(4)
j7 = koeficienty7(3)
k7 = koeficienty7(2)
l7 = koeficienty7(1)
fProjekciaVelkymPolynomom = a7*t.^11 + b7*t.^10 + c7*t.^9 + d7*t.^8 + e7*t.^7 + f7*t.^6 + g7*t.^5 + h7*t.^4 + i7*t.^3 + j7*t.^2 + k7*t.^1 + l7
chyba7 = abs(f-fProjekciaVelkymPolynomom)
energiaRozdielovehoVektora7 = sqrt(sum(chyba7.^2))
priemernaChybaTakmerOptimalna = energiaRozdielovehoVektora7 / length(t)
vektorPriemernychChyb(9) = priemernaChybaTakmerOptimalna


vektorPriemernychChyb
rozdielOprotiMinimalnejPriemernejChybe = vektorPriemernychChyb - min(vektorPriemernychChyb)

plot(t, f)
plot(t, f, t, fProjekciaParabolouTriParametre, t, fProjekciaPolynomomTretiehoStupnaStyriParametre, t, fProjekciaPolynomomStvrtehoStupnaPatParametrov, t, fProjekciaPolynomomPiatehoStupna, t, fProjekciaPolynomomSiestehoStupna, t, fProjekciaVelkymPolynomom, '-.')
%plot(t, f, t, fProjekciaPriamkou, t, fProjekciaParabolou, t, fProjekciaPriamkouDvaParametre, t, fProjekciaParabolouTriParametre, t, fProjekciaPolynomomTretiehoStupnaStyriParametre, t, fProjekciaPolynomomStvrtehoStupnaPatParametrov, t, fProjekciaPolynomomPiatehoStupna, t, fProjekciaPolynomomSiestehoStupna, t, fProjekciaVelkymPolynomom, '-.')