format short
t = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108]
fOriginal = [97.81 93.995 90.255 110 138.635 147.075 143.88 143 158.23 186.07 202.455 207.43 216.33 181.31 195 208.97 185.91 209.665 193.3 189.265 200.95 238.195 242.405 230.24 250.75 224.725 229.08 235.69 248.955 261.35 255 257.625 283.635 353.5 346.5 345.74 282.15 235.59 220.235 287.145 292.9 263.21 236.875 231.645 200.26 179.68 146.48 153.825 169.265 168.995 174.03 197.985 208.615 210.795 221.525 230.835 247.925 268.06 291.5 309.99 264.97 263.4 283.56 262.85 242.815 222.475 242.425 225.01 262.895 306.85 277.855 296.985 300.18 306.7 293.38 272.05 264.51 253.19 301.845 270.48 257.52 296.32 299.695 322.95 290.055 309.125 320.62 302.425 290.43 290.035 316.485 342.545 377.25 340.15 349.185 353.69 377.845 400.6 397.095 412.285 435.61 440.185 443.875 423.45 437.955 515.29 529.795 555.92 ]

%vyhladenie 2. stupna - 1 pred, 1 za
b0  = fOriginal(1:length(fOriginal)-2)
b1  = fOriginal(3:length(fOriginal))
f   = fOriginal(2:length(fOriginal)-1)

maticaA = [
    b0*b0', b1*b0'
    b0*b1', b1*b1'
]

praveStrany = [
    f*b0'
    f*b1'
]

'Koeficienty vyhladenia 2. stupna'
koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(2)
c1 = koeficienty(1)

vyhladenieDruhehoStupna = c0*b0 + c1*b1


%1. a posledny prirad zo zasumeneho sinusu (funkcia, ktoru chceme
%vyhladzovat), zvysok (medzi nimi) dopln z uz vyhladeneho vektora
vyhladenieCeleDruhehoStupna = [fOriginal(1) vyhladenieDruhehoStupna fOriginal(length(t))]





%vyhladenie 3. stupna - 2 pred, 1 za

%bazicke vektory a vyhladzovane funkcne hodnoty musia byt o 2+1 = 3 prvky
%kratsie
b0  = fOriginal(1:length(fOriginal)-3)
b1  = fOriginal(2:length(fOriginal)-2)
b2  = fOriginal(4:length(fOriginal))
f   = fOriginal(3:length(fOriginal)-1)

maticaA = [
    b0*b0', b1*b0' b2*b0'
    b0*b1', b1*b1' b2*b1'
    b0*b2', b1*b2' b2*b2'
]

praveStrany = [
    f*b0'
    f*b1'
    f*b2'
]

'Koeficienty vyhladenia 3. stupna (A)'
koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(3)
c1 = koeficienty(2)
c2 = koeficienty(1)

vyhladenieTretiehoStupnaTypA = c0*b0 + c1*b1 + c2*b2

%prve dva a posledny prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
vyhladenieCeleTretiehoStupnaTypA = [fOriginal(1) fOriginal(2) vyhladenieTretiehoStupnaTypA fOriginal(length(t))]









%vyhladenie 3. stupna - 1 pred, 2 za

b0  = fOriginal(1:length(fOriginal)-3)
b1  = fOriginal(3:length(fOriginal)-1)
b2  = fOriginal(4:length(fOriginal))
f   = fOriginal(2:length(fOriginal)-2)

maticaA = [
    b0*b0', b1*b0' b2*b0'
    b0*b1', b1*b1' b2*b1'
    b0*b2', b1*b2' b2*b2'
]

praveStrany = [
    f*b0'
    f*b1'
    f*b2'
]

'Koeficienty vyhladenia 3. stupna (B)'
koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(3)
c1 = koeficienty(2)
c2 = koeficienty(1)

vyhladenieTretiehoStupnaTypB = c0*b0 + c1*b1 + c2*b2

%prvy a posledne dva prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
velkost = length(t)
vyhladenieCeleTretiehoStupnaTypB = [fOriginal(1) vyhladenieTretiehoStupnaTypB fOriginal(velkost-1) fOriginal(velkost)]






%vyhladenie 4. stupna - 2 pred, 2 za

b0  = fOriginal(1:length(fOriginal)-4)
b1  = fOriginal(2:length(fOriginal)-3)
b2  = fOriginal(4:length(fOriginal)-1)
b3  = fOriginal(5:length(fOriginal))
f   = fOriginal(3:length(fOriginal)-2)

maticaA = [
    b0*b0', b1*b0' b2*b0' b3*b0'
    b0*b1', b1*b1' b2*b1' b3*b1'
    b0*b2', b1*b2' b2*b2' b3*b2'
    b0*b3', b1*b3' b2*b3' b3*b3'
]

praveStrany = [
    f*b0'
    f*b1'
    f*b2'
    f*b3'
]

'Koeficienty vyhladenia 4. stupna'
koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(4)
c1 = koeficienty(3)
c2 = koeficienty(2)
c3 = koeficienty(1)

vyhladenieStvrtehoStupna = c0*b0 + c1*b1 + c2*b2 + c3*b3

%prve dva a posledne dva prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
velkost = length(t)
vyhladenieCeleStvrtehoStupna = [fOriginal(1) fOriginal(2) vyhladenieStvrtehoStupna fOriginal(velkost-1) fOriginal(velkost)]



%***************************___GRAFY___***************************
%******VYHLADZOVANIE
%plot(t, fOriginal, t, vyhladenieCeleDruhehoStupna)
%plot(t, fOriginal, t, vyhladenieCeleTretiehoStupnaTypA)
%plot(t, fOriginal, t, vyhladenieCeleTretiehoStupnaTypB)
%plot(t, fOriginal, t, vyhladenieCeleStvrtehoStupna)

%plot(t, fOriginal, '-')
%plot(t, fOriginal, t, vyhladenieCeleDruhehoStupna, '-.')
%plot(t, fOriginal, t, vyhladenieCeleDruhehoStupna, t, vyhladenieCeleTretiehoStupnaTypA, '-.')
%plot(t, fOriginal, t, vyhladenieCeleDruhehoStupna, t, vyhladenieCeleTretiehoStupnaTypA, t, vyhladenieCeleTretiehoStupnaTypB, '-.')
%plot(t, fOriginal, t, vyhladenieCeleDruhehoStupna, t, vyhladenieCeleTretiehoStupnaTypA, t, vyhladenieCeleTretiehoStupnaTypB, t, vyhladenieCeleStvrtehoStupna, '-.')

%maticaChyb = [
%    sum(abs(fOriginal-vyhladenieCeleDruhehoStupna).^1)
%    sum(abs(fOriginal-vyhladenieCeleTretiehoStupnaTypA).^1)
%    sum(abs(fOriginal-vyhladenieCeleTretiehoStupnaTypB).^1)
%    sum(abs(fOriginal-vyhladenieCeleStvrtehoStupna).^1)
%]




%*********************___PREDIKCIA___*********************
%1. stupna
%f(k) = c*f(k-1)

%predikcia

%zobrat 90% dat zo zaciatku a skusime predikovat poslednych 10% dat a
%porovnat s originalnymi datami

t = 1:1:118
%fOriginal zostava rovnake
fFuture = [97.81 93.995 90.255 110 138.635 147.075 143.88 143 158.23 186.07 202.455 207.43 216.33 181.31 195 208.97 185.91 209.665 193.3 189.265 200.95 238.195 242.405 230.24 250.75 224.725 229.08 235.69 248.955 261.35 255 257.625 283.635 353.5 346.5 345.74 282.15 235.59 220.235 287.145 292.9 263.21 236.875 231.645 200.26 179.68 146.48 153.825 169.265 168.995 174.03 197.985 208.615 210.795 221.525 230.835 247.925 268.06 291.5 309.99 264.97 263.4 283.56 262.85 242.815 222.475 242.425 225.01 262.895 306.85 277.855 296.985 300.18 306.7 293.38 272.05 264.51 253.19 301.845 270.48 257.52 296.32 299.695 322.95 290.055 309.125 320.62 302.425 290.43 290.035 316.485 342.545 377.25 340.15 349.185 353.69 377.845 400.6 397.095 412.285 435.61 440.185 443.875 423.45 437.955 515.29 529.795 560.355 590.485 607.825 557.255 534.88 571.65 584.67 579.55 582.36 588.41 567.87]

%predikcia 1. stupna
%f(k+1) = c0 * f(k-1)
b0 = fOriginal(1:length(fOriginal)-1)
fNove = fOriginal(2:length(fOriginal))  %najskor mozem ist od druheho, lebo nemozem predikovat prvy (prvy nema predchodcu, kedze je to vyhladzovanie prveho stupna, pocitame nasledujuci na zaklade predosleho)

%1 = c * 0
%2 = c * 1
%3 = c * 2
%...
%8 = c * 7

'Koeficienty predikcie 1. stupna'
c0 = (fNove*b0') / (b0*b0')

%vypocitaj predikovane funkcne hodnoty
f8 = c0 * fOriginal(length(fOriginal))
f9 = c0 * f8
f10 = c0 * f9
f11 = c0 * f10
f12 = c0 * f11
f13 = c0 * f12
f14 = c0 * f13
f15 = c0 * f14
f16 = c0 * f15
f17 = c0 * f16

predikciaPrvyStupen = [f8 f9 f10 f11 f12 f13 f14 f15 f16 f17]



%predikcia 2. stupna
%f(k+1) = c1 * f(k-1) + c2 * f(k-2)
fNove = fOriginal(3:length(fOriginal))  %najskor mozem ist od tretieho
b1 = fOriginal(2:length(fOriginal)-1)
b2 = fOriginal(1:length(fOriginal)-2)

maticaA = [
    b1*b1' b2*b1'
    b1*b2' b2*b2'
]

praveStrany = [
    fNove * b1'
    fNove * b2'
]

'Koeficienty predikcie 2. stupna'
koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)


%predikovane funkcne hodnoty
f8 = c1 * f(length(f)) + c2 * f(length(f)-1)
f9 = c1 * f8 + c2 * f(length(f))
f10 = c1 * f9 + c2 * f8
f11 = c1 * f10 + c2 * f9
f12 = c1 * f11 + c2 * f10
f13 = c1 * f12 + c2 * f11
f14 = c1 * f13 + c2 * f12
f15 = c1 * f14 + c2 * f13
f16 = c1 * f15 + c2 * f14
f17 = c1 * f16 + c2 * f15

predikciaDruhyStupen = [f8 f9 f10 f11 f12 f13 f14 f15 f16 f17]









%predikcia 3. stupna
%f(k+1) = c1 * f(k-1) + c2 * f(k-2) + c3 * f(k-3)
fNove = fOriginal(4:length(fOriginal))  %najskor mozem ist od stvrteho
b1 = fOriginal(3:length(fOriginal)-1)
b2 = fOriginal(2:length(fOriginal)-2)
b3 = fOriginal(1:length(fOriginal)-3)

maticaA = [
    b1*b1' b2*b1' b3*b1'
    b1*b2' b2*b2' b3*b2'
    b1*b3' b2*b3' b3*b3'
]

praveStrany = [
    fNove * b1'
    fNove * b2'
    fNove * b3'
]

'Koeficienty predikcie 3. stupna'
koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)
c3 = koeficienty(3)

f8 = c1 * fOriginal(length(fOriginal)) + c2 * fOriginal(length(fOriginal)-1) + c3 * fOriginal(length(fOriginal)-2)
f9 = c1 * f8 + c2 * fOriginal(length(fOriginal)) + c3 * fOriginal(length(fOriginal)-1)
f10 = c1 * f9 + c2 * f8 + c3 * fOriginal(length(fOriginal))
f11 = c1 * f10 + c2 * f9 + c3 * f8
f12 = c1 * f11 + c2 * f10 + c3 * f9
f13 = c1 * f12 + c2 * f11 + c3 * f10
f14 = c1 * f13 + c2 * f12 + c3 * f11
f15 = c1 * f14 + c2 * f13 + c3 * f12
f16 = c1 * f15 + c2 * f14 + c3 * f13
f17= c1 * f16 + c2 * f15 + c3 * f14

predikciaTretiStupen = [f8 f9 f10 f11 f12 f13 f14 f15 f16 f17]




%predikcia 4. stupna
%f(k+1) = c1*f(k) + c2*f(k-1) + c3*f(k-2) + c4*f(k-3)
fNove = fOriginal(5:length(fOriginal))  %najskor mozem ist od piateho
b1 = fOriginal(4:length(fOriginal)-1)
b2 = fOriginal(3:length(fOriginal)-2)
b3 = fOriginal(2:length(fOriginal)-3)
b4 = fOriginal(1:length(fOriginal)-4)
maticaA = [
    b1*b1' b2*b1' b3*b1' b4*b1'
    b1*b2' b2*b2' b3*b2' b4*b2'
    b1*b3' b2*b3' b3*b3' b4*b3'
    b1*b4' b2*b4' b3*b4' b4*b4'
    ]

praveStrany = [
    fNove * b1'
    fNove * b2'
    fNove * b3'
    fNove * b4'
]

'Koeficienty predikcie 4. stupna'
koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)
c3 = koeficienty(3)
c4 = koeficienty(4)

f8 = c1 * fOriginal(length(fOriginal)) + c2 * fOriginal(length(fOriginal)-1) + c3 * fOriginal(length(fOriginal)-2) + c4 * fOriginal(length(fOriginal)-3)
f9 = c1 * f8 + c2 * fOriginal(length(fOriginal)) + c3 * fOriginal(length(fOriginal)-1) + c4 * fOriginal(length(fOriginal)-2)
f10 = c1 * f9 + c2 * f8 + c3 * fOriginal(length(fOriginal)) + c4 * fOriginal(length(fOriginal)-1)
f11 = c1 * f10 + c2 * f9 + c3 * f8 + c4 * fOriginal(length(fOriginal))
f12 = c1 * f11 + c2 * f10 + c3 * f9 + c4 * f8
f13 = c1 * f12 + c2 * f11 + c3 * f10 + c4 * f9
f14 = c1 * f13 + c2 * f12 + c3 * f11 + c4 * f10
f15 = c1 * f14 + c2 * f13 + c3 * f12 + c4 * f11
f16 = c1 * f15 + c2 * f14 + c3 * f13 + c4 * f12
f17 = c1 * f16 + c2 * f15 + c3 * f14 + c4 * f13


predikciaStvrtyStupen = [f8 f9 f10 f11 f12 f13 f14 f15 f16 f17]


tChvost = 109:1:118
fFutureChvost = fFuture(length(fOriginal)+1:length(fFuture))

a = sum(abs(fFutureChvost-predikciaPrvyStupen).^1)
b =    sum(abs(fFutureChvost-predikciaDruhyStupen).^1)
c =    sum(abs(fFutureChvost-predikciaTretiStupen).^1)
d =    sum(abs(fFutureChvost-predikciaStvrtyStupen).^1)




maticaChybPredikcie = [
    sum(abs(fFutureChvost-predikciaPrvyStupen).^1)
    sum(abs(fFutureChvost-predikciaDruhyStupen).^1)
    sum(abs(fFutureChvost-predikciaTretiStupen).^1)
    sum(abs(fFutureChvost-predikciaStvrtyStupen).^1)
]



%***************************___GRAFY___***************************
%******PREDIKCIA
%plot(tChvost, fFutureChvost, '-')
%plot(tChvost, fFutureChvost, tChvost, predikciaPrvyStupen, '-.')
%plot(tChvost, fFutureChvost, tChvost, predikciaPrvyStupen, tChvost, predikciaDruhyStupen, '-.')
%plot(tChvost, fFutureChvost, tChvost, predikciaPrvyStupen, tChvost, predikciaDruhyStupen, tChvost, predikciaTretiStupen, '-.')
plot(tChvost, fFutureChvost, tChvost, predikciaPrvyStupen, tChvost, predikciaDruhyStupen, tChvost, predikciaTretiStupen, tChvost, predikciaStvrtyStupen, '-.')
%plot
%plot
%plot

grid on
xlabel('Rok')
ylabel('Cena akcií (v USD)')
ax = gca;
%mame data z 9 rokov - od roku 1/2005 do 12/2013 tj 12*9=108 dat.
%Jeden rok bude teda zaberat 12 tikov, nasledujuci tik bude prvy mesiac v
%roku
ax.XTick = [1, 1+12, 1+12*2, 1+12*3, 1+12*4, 1+12*5, 1+12*6 1+12*7, 1+12*8, 12*9]
ax.XTickLabel = {'1/2005', '1/2006', '1/2007', '1/2008', '1/2009', '1/2010', '1/2011', '1/2012', '1/2013', '12/2013'}