import math

def nCr(n,r):
    f = math.factorial
    return f(n) / f(r) / f(n-r)
def Cabk():
	for k in range(1,10):
		for j in range(1,10):
			print("%8.10f"%((nCr(10,k)*nCr(990,10-j))/nCr(1000,10)))
		
	
		
if __name__ == '__main__':
		#Cabk()
		print("%8.40f"%(nCr(990,10)/nCr(1000,10)))