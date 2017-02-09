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

%predikcia prveho stupna
%f(k+1) = c0 * f(k-1)
b0 = f(1:length(f)-1)
fNove = f(2:length(f))

%1 = c * 0
%2 = c * 1
%3 = c * 2
%...
%8 = c * 7

c0 = (fNove*b0') / (b0*b0')
fPredikovane = c0*f(length(f)) %f(8) = 1.23* 7 = 8.61
%f(9) = 1.23 * 8,61 = 




%predikcia druheho stupna
%f(k+1) = c1 * f(k-1) + c2 * f(k-2)
fNove = f(3:8)  %najskor mozem ist od druheho
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

f(length(f))
f(length(f)-1)

fPredikovane = c1*f(length(f)) + c2*f(length(f)-1)



%***************************___GRAFY___***************************
plot(t, zasumenySinus, t, vyhladenieCeleDruhehoStupna)
%plot(t, zasumenySinus, t, vyhladenieCeleTretiehoStupnaTypA)
%plot(t, zasumenySinus, t, vyhladenieCeleTretiehoStupnaTypB)
%plot(t, zasumenySinus, t, vyhladenieCeleStvrtehoStupna)

%editor grafu -> edit -> kliknut na vyhladenie a vymazat
%tool -> basic fitting -> zakliknut jednotlive stupne polynomov
%zakliknut si nanajvys 8, 9, 10
%zoberieme koeficienty polynomu 10 stupna a vyhodime 3 najmensie koeficienty
%tym najdeme polynomicky model a najst chybu
%do buduceho cvika