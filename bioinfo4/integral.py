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
interval = [float(j) / 100 for j in range(a, N, 1)]
for x in interval:
	for i in xrange(a, b):
		plot += f(a+i*h)
	plot_t.append(((plot ** x) * 2.0 + f(a) + f(b)) * h)
	integral += plot ** x

integral = (integral * 2.0 + f(a) + f(b)) * h
print 'trapeciju: ', integral

#Simpsono
plot = 0
integral = 0
for x in interval:
	for i in xrange(a, b):
		plot += f(i)
	if x == 0.0 or x == 1.0:
		plot_s.append(h/3*(plot ** x))
		integral += plot ** x
	else:
		if x%2 == 0:
			plot_s.append(h/3*2*(plot**x))
			integral += 2*(plot**x)
		else:
			plot_s.append(h/3*4*(plot**x))
			integral += 4*(plot**x)

integral = (h/3.0)*integral
print 'simpsono: ', integral

plt.text(0.2, 1.65, r"$\int_{0}^{1}(1 - x)^{\alpha{sinx}}dx$", horizontalalignment = 'center', fontsize = 20)
plt.figtext(0.9, 0.05, '$x$')
plt.figtext(0.1, 0.9, '$y$')
plt.plot(interval,plot_t, label="Trapeciju metodas")
plt.plot(interval,plot_s, label="Simpsono formule")
# plt.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3,
#            ncol=2, mode="expand", borderaxespad=0.)
plt.text(0.08, 0.2, 'Trapeciju metodas')
plt.text(0.9, 0.2, 'Simpsono formule')
plt.show()
