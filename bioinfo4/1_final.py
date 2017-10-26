from __future__ import division
import math
import matplotlib.pyplot as plt
from numpy import array

def f(x,alpha):
  return (1 - (x))**(alpha * math.sin(x))


plot_t = []
plt_s = []
plot_s = 0
plot = 0
integral = 0
a = 0.0
b = 1.0
N = 100
h = (b - a) / N
interval = range(0,101)

for i in interval:
    alpha = i*0.01
    plot = 0.0
    plot_s = 0.0
    for j in interval:
        x = j * h
        if j == 0 or j == 1:
            plot += (f(x, alpha) * h/2)
        else:
            plot += (f(x, alpha) * h)
    plot_t.append(plot)
    for k in interval:
        x = k*h
        if k == 0.0 or k == 1.0:
           plot_s += (h/3*f(x,alpha))
           integral += h/3*f(x,alpha)
        else:
           if k%2 == 0:
               plot_s +=(h/3*2*f(x,alpha))
           else:
               plot_s += (h/3*4*f(x,alpha))
    plt_s.append(plot_s)

print plot
print plot_s


plt.text(75, 0.95, r"$\int_{0}^{1}(1 - x)^{\alpha{sinx}}dx$", horizontalalignment = 'center', fontsize = 20)
plt.figtext(0.9, 0.05, '$x$')
plt.figtext(0.1, 0.9, '$y$')
plt.plot(interval,plot_t, label="Trapeciju metodas")
plt.plot(interval,plt_s, label="Simpsono formule")
plt.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3,
           ncol=2, mode="expand", borderaxespad=0.)
plt.text(0.08, 0.2, 'Trapeciju metodas')
plt.text(0.9, 0.2, 'Simpsono formule')
plt.show()
