format short
t = [0 1 2 3 4]
f = [0 1 3 5 8]

a1 =(f*t')/(t*t')
fProjekciaPriamkou = a1 * t
chyba1 = abs(f-fProjekciaPriamkou)
energiaRozdielovehoVektora1 = sqrt(sum(chyba1.^2))
priemernaChyba1 = energiaRozdielovehoVektora1 / length(t)



tNaDruhu = t.^2
a2 = (f*tNaDruhu') / (tNaDruhu*tNaDruhu')
fProjekciaParabolou = a2 * tNaDruhu
chyba2 = abs(f-fProjekciaParabolou)
energiaRozdielovehoVektora2 = sqrt(sum(chyba2.^2))
priemernaChyba2 = energiaRozdielovehoVektora2 / length(t)





bazaKoeficientuB3 = [1 1 1 1 1]
bazaKoeficientuA3 = [0 1 2 3 4]
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




bazaKoeficientuC4 = [1 1 1 1 1]
bazaKoeficientuB4 = [0 1 2 3 4]
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




bazaKoeficientuD5 = [1 1 1 1 1]
bazaKoeficientuC5 = [0 1 2 3 4]
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




plot(t, f, t, fProjekciaPriamkou, t, fProjekciaParabolou, t, fProjekciaPriamkouDvaParametre, t, fProjekciaParabolouTriParametre, t, fProjekciaPolynomomTretiehoStupnaStyriParametre, '-*')
plot(t, f, t, fProjekciaPolynomomTretiehoStupnaStyriParametre, '-*')