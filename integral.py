from __future__ import division
import math
import matplotlib.pyplot as plt
from numpy import array


#
#
#Trapecijos

def f(x):
  return (1 - (x))**math.sin(x)


plot_t = []
plot_s = []
plot = 0
integral = 0
a = 0
b = 1
N = 100
h = (b - a) / N
print h
interval = [float(j) / 100 for j in range(a, N+1, 1)]
for x in interval:
	for i in xrange(a, b):
		plot += f(a+i*h)
	plot_t.append(plot ** x)
	integral += plot ** x

integral = (integral * 2.0 + f(a) + f(b)) * h
print integral
plt.plot(interval,plot_t)
plt.show()

#Simpsono
plot = 0
integral = 0
for x in interval:
	for i in xrange(a, b):
		plot += f(i)
	if x == 0.0 or x == 1.0:
		plot_s.append(plot ** x)
		integral += plot ** x
	else:
		if x%2 == 0:
			plot_s.append( 2*(plot**x))
			integral += 2*(plot**x)
		else:
			plot_s.append(4*(plot**x))
			integral += 4*(plot**x)

integral = (h/3.0)*integral
print integral

plt.plot(interval,plot_s)
plt.show()
