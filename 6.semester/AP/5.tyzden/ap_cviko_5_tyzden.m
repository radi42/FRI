maticaA4 = [89.48, 23.58
    23.58, 6.3]
praveStrany4 = [44.41
    11.63]
koeficienty4 = linsolve(maticaA4, praveStrany4)




f = [4 2.3 0.1]
b0 = [8.2 4 0.22]
b1 = [2.3 0.8 0.05]
A = [b0*b0' b1*b0'
     b0*b1' b1*b1']
d = [f*b0'
     f*b1']
koeficienty = linsolve(A, d)



f = [4 2.3 0.8 0.56]
b0 = [8.2 4 2.3 0.8]
c0 = (f*b0') / (b0*b0')
c0*0.56