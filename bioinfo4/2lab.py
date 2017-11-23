import math
import sys
import math
import matplotlib.pyplot as plt
from numpy import array


fname = sys.argv[1]
X = []
points = []
Y = []
if fname:
    with open(fname) as f:
    	N = f.readline()[:-1]
    	for line in f:
			# print line
			x, y = line[:-1].split(' ', 1)
			# print x, y
			X.append(float(x))
			Y.append(float(y))
			points.append([float(x),float(y)])
else:
    N = raw_input('Choose a number: ')
    for p in xrange(0, N):
		point = raw_input('Write a point: ')
		x, y = point.split()
		# print x, y
		X.append(float(x))
		Y.append(float(y))
		points.append([float(x),float(y)])

for i in X:
	points = sorted(points, key=lambda p: abs(p[0] - i))[:4]
# plt.show()

x0 = points[0][0]
y0 = points[0][1]
x1 = points[1][0]
y1 = points[1][1]
x2 = points[2][0]
y2 = points[2][1]
x3 = points[3][0]
y3 = points[3][1]
# print points
x_axis = []
y_axis = []
a = min([x0, x1, x2, x3])
b = max([x0, x1, x2, x3])
N_ = int(N)**2
x_axis_ = [points[i][0] for i in xrange(0, int(N))]
y_axis_ = [points[i][1] for i in xrange(0, int(N))]
plt.plot(x_axis_, y_axis_, label="Trapeciju metodas")
for j in xrange(0, N_):
	xj= a + (j-1)*(b-a)/(N_)
	L0 = (xj-x1)*(xj-x2)*(xj-x3) / ((x0-x1)*(x0-x2)*(x0-x3))
	L1 = (xj-x0)*(xj-x2)*(xj-x3) / ((x1-x0)*(x1-x2)*(x1-x3))
	L2 = (xj-x0)*(xj-x1)*(xj-x3) / ((x2-x0)*(x2-x1)*(x2-x3))
	L3 = (xj-x0)*(xj-x1)*(xj-x2) / ((x3-x0)*(x3-x1)*(x3-x2))
	f_x = L0*y0 + L1*y1 + L2*y2 + L3*y3
	x_axis.append(xj)
	y_axis.append(f_x)
	# print xj, f_x

x_axis = array(x_axis)
y_axis = array(y_axis)

plt.plot(x_axis, y_axis, label="Trapeciju metodas")
plt.show()
