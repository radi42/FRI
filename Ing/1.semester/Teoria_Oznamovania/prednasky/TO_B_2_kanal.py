from coroutine import coroutine
import random

oprava = 9

def vysielac():
 target = koder()
 target.send("Mr Watson come here")

@coroutine
def koder():
 target = kanal()
 while True:
  prijate = (yield)
  for i in range(len(prijate)):
   target.send((0x1 << oprava) | ord(prijate[i]))

@coroutine
def kanal():
 target = dekoder()
 while True:
  prijate = (yield)
  if random.randint(0,1) == 1:
   target.send(~prijate)
  else:
   target.send(prijate)

@coroutine
def dekoder():
  target = prijimac()
  while True:
   prijate = (yield)
   if prijate & (0x1 << oprava):
	  dekodovane = prijate & 0xff
   else:
	  dekodovane = (~prijate) & 0xff
   target.send(dekodovane) 

@coroutine
def prijimac():
		while True:
			prijate = (yield)
			print(chr(prijate))
				
vysielac()
