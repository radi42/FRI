%y(t)= sin(t) + ei(chyba)

t = linspace(0, 1, 100)    %rozdel interval od 0 po 1 na 100 casti
sinus = sin(2*pi*t)
a = 0.05    %amplituda sumu
kmitanie = 2 * a * rand(1, length(sinus)) - a    %v intervale od <-a,a>
zasumenySinus = sinus + kmitanie
size(t)

%teraz zasumeny sinus treba vyhladit

%vyhladenie 2. stupna - 1 pred, 1 za
b0  = zasumenySinus(1:length(zasumenySinus)-2)
b1  = zasumenySinus(3:length(zasumenySinus))
f   = zasumenySinus(2:length(zasumenySinus)-1)

maticaA = [
    b0*b0', b1*b0'
    b0*b1', b1*b1'
]

praveStrany = [
    f*b0'
    f*b1'
]

koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(2)
c1 = koeficienty(1)

vyhladenieDruhehoStupna = c0*b0 + c1*b1

%1. a posledny prirad zo zasumeneho sinusu (funkcia, ktoru chceme
%vyhladzovat), zvysok (medzi nimi) dopln z uz vyhladeneho vektora
vyhladenieCeleDruhehoStupna = [zasumenySinus(1) vyhladenieDruhehoStupna zasumenySinus(length(t))]




%vyhladenie 3. stupna - 2 pred, 1 za

%bazicke vektory a vyhladzovane funkcne hodnoty musia byt o 2+1 = 3 prvky
%kratsie
b0  = zasumenySinus(1:length(zasumenySinus)-3)
b1  = zasumenySinus(2:length(zasumenySinus)-2)
b2  = zasumenySinus(4:length(zasumenySinus))
f   = zasumenySinus(3:length(zasumenySinus)-1)

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

koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(3)
c1 = koeficienty(2)
c2 = koeficienty(1)

vyhladenieTretiehoStupnaTypA = c0*b0 + c1*b1 + c2*b2

%prve dva a posledny prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
vyhladenieCeleTretiehoStupnaTypA = [zasumenySinus(1) zasumenySinus(2) vyhladenieTretiehoStupnaTypA zasumenySinus(length(t))]









%vyhladenie 3. stupna - 1 pred, 2 za

b0  = zasumenySinus(1:length(zasumenySinus)-3)
b1  = zasumenySinus(3:length(zasumenySinus)-1)
b2  = zasumenySinus(4:length(zasumenySinus))
f   = zasumenySinus(2:length(zasumenySinus)-2)

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

koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(3)
c1 = koeficienty(2)
c2 = koeficienty(1)

vyhladenieTretiehoStupnaTypB = c0*b0 + c1*b1 + c2*b2

%prvy a posledne dva prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
velkost = length(t)
vyhladenieCeleTretiehoStupnaTypB = [zasumenySinus(1) vyhladenieTretiehoStupnaTypB zasumenySinus(velkost-1) zasumenySinus(velkost)]






%vyhladenie 4. stupna - 2 pred, 2 za

b0  = zasumenySinus(1:length(zasumenySinus)-4)
b1  = zasumenySinus(2:length(zasumenySinus)-3)
b2  = zasumenySinus(4:length(zasumenySinus)-1)
b3  = zasumenySinus(5:length(zasumenySinus))
f   = zasumenySinus(3:length(zasumenySinus)-2)

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

koeficienty = linsolve(maticaA, praveStrany)
c0 = koeficienty(4)
c1 = koeficienty(3)
c2 = koeficienty(2)
c3 = koeficienty(1)

vyhladenieStvrtehoStupna = c0*b0 + c1*b1 + c2*b2 + c3*b3

%prve dva a posledne dva prirad zo zasumeneho sinusu , zvysok (medzi nimi) 
%dopln z uz vyhladeneho vektora
velkost = length(t)
vyhladenieCeleStvrtehoStupna = [zasumenySinus(1) zasumenySinus(2) vyhladenieStvrtehoStupna zasumenySinus(velkost-1) zasumenySinus(velkost)]






%*********************___PREDIKCIA___*********************
%1. stupna
%f(k) = c*f(k-1)

%predikcia

%zobrat 90% dat zo zaciatku a skusime predikovat poslednych 10% dat a
%porovnat s originalnymi datami

%t = [0 1 2 3 4 5 6 7]
f = [0 1 2 3 4 5 6 7]   %podla fcie y(t)=t

%predikcia 1. stupna
%f(k+1) = c0 * f(k-1)
b0 = f(1:length(f)-1)
fNove = f(2:length(f))  %najskor mozem ist od druheho

%1 = c * 0
%2 = c * 1
%3 = c * 2
%...
%8 = c * 7

c0 = (fNove*b0') / (b0*b0')

%vypocitaj predikovane funkcne hodnoty
f8 = c0 * f(length(f)) %f(8) = 1.23* 7 = 8.61
f9 = c0 * f8
f10 = c0 * f9
f11 = c0 * f10
f12 = c0 * f11
f13 = c0 * f12
f14 = c0 * f13
f15 = c0 * f14





%predikcia 2. stupna
%f(k+1) = c1 * f(k-1) + c2 * f(k-2)
fNove = f(3:8)  %najskor mozem ist od tretieho
b1 = f(2:7)
b2 = f(1:6)

maticaA = [
    b1*b1' b2*b1'
    b1*b2' b2*b2'
]

praveStrany = [
    fNove * b1'
    fNove * b2'
]


koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)

f(length(f))    %posledny
f(length(f)-1)  %a predposledny prvok z vektora f

f8 = c1 * f(length(f)) + c2 * f(length(f)-1)
f9 = c1 * f8 + c2 * f(length(f))
f10 = c1 * f9 + c2 * f8
f11 = c1 * f10 + c2 * f9
f12 = c1 * f11 + c2 * f10
f13 = c1 * f12 + c2 * f11
f14 = c1 * f13 + c2 * f12
f15 = c1 * f14 + c2 * f13











%predikcia 3. stupna
%f(k+1) = c1 * f(k-1) + c2 * f(k-2) + c3 * f(k-3)
fNove = f(4:8)  %najskor mozem ist od stvrteho
b1 = f(3:7)
b2 = f(2:6)
b3 = f(1:5)

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


koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)
c3 = koeficienty(3)

f8 = c1 * f(length(f)) + c2 * f(length(f)-1) + c3 * f(length(f)-2)
f9 = c1 * f8 + c2 * f(length(f)) + c3 * f(length(f)-1)
f10 = c1 * f9 + c2 * f8 + c3 * f(length(f))
f11 = c1 * f10 + c2 * f9 + c3 * f8
f12 = c1 * f11 + c2 * f10 + c3 * f9
f13 = c1 * f12 + c2 * f11 + c3 * f10
f14 = c1 * f13 + c2 * f12 + c3 * f11
f15 = c1 * f14 + c2 * f13 + c3 * f12






%predikcia 4. stupna
%f(k+1) = c1*f(k) + c2*f(k-1) + c3*f(k-2) + c4*f(k-3)
fNove = f(5:8)  %najskor mozem ist od piateho
b1 = f(4:7)
b2 = f(3:6)
b3 = f(2:5)
b4 = f(1:4)
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


koeficienty = linsolve(maticaA, praveStrany)
c1 = koeficienty(1)
c2 = koeficienty(2)
c3 = koeficienty(3)
c4 = koeficienty(4)

f8 = c1 * f(length(f)) + c2 * f(length(f)-1) + c3 * f(length(f)-2) + c4 * f(length(f)-3)
f9 = c1 * f8 + c2 * f(length(f)) + c3 * f(length(f)-1) + c4 * f(length(f)-2)
f10 = c1 * f9 + c2 * f8 + c3 * f(length(f)) + c4 * f(length(f)-1)
f11 = c1 * f10 + c2 * f9 + c3 * f8 + c4 * f(length(f))
f12 = c1 * f11 + c2 * f10 + c3 * f9 + c4 * f8
f13 = c1 * f12 + c2 * f11 + c3 * f10 + c4 * f9
f14 = c1 * f13 + c2 * f12 + c3 * f11 + c4 * f10
f15 = c1 * f14 + c2 * f13 + c3 * f12 + c4 * f11








%***************************___GRAFY___***************************
%******VYHLADZOVANIE
%plot(t, zasumenySinus, t, vyhladenieCeleDruhehoStupna)
%plot(t, zasumenySinus, t, vyhladenieCeleTretiehoStupnaTypA)
%plot(t, zasumenySinus, t, vyhladenieCeleTretiehoStupnaTypB)
%plot(t, zasumenySinus, t, vyhladenieCeleStvrtehoStupna)

%******PREDIKCIA
%plot
%plot
%plot
%plot



%3. zadanie - poznamky
%editor grafu -> edit -> kliknut na vyhladenie a vymazat
%tool -> basic fitting -> zakliknut jednotlive stupne polynomov
%zakliknut si nanajvys 8, 9, 10
%zoberieme koeficienty polynomu 10 stupna a vyhodime 3 najmensie koeficienty
%tym najdeme polynomicky model a najst chybu
%do buduceho cvika