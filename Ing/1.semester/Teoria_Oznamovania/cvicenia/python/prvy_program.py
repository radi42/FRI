#for number in range(100):
#    print(number)

def faktorial(cislo)	
	num = int(cislo)
	for x in range(1, num):
		num = num * x
	
	print(num)
	return num;


faktorial(5)
