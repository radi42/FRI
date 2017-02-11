class Polynom:
	def __init__(self, koef):
		self.koef = koef
		self.stupen = len(koef) - 1

	def printPolynom(self):
		vypis = ""
		x = self.stupen
		#for x in range(self.stupen, -1, -1):
		#	vypis += "+" + str(self.koef[x])+"x^"+str(self.stupen)
		
		while(x>=0)
			vypis += "+" + str(self.koef[x])+"x^"+int(x)
			x=x-1
		print(vypis)

koef = [1,0,0,0]
poly = Polynom(koef)
poly.printPolynom()
