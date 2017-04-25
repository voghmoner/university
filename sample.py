import numpy as np
import math
v1 = np.array([41.845, 80.474, 14.263]);
v2 = np.array([43.282, 83.517, 13.842]); 
v3 = np.array([44.289, 84.369, 14.465]);
v4 = np.array([43.600, 85.414, 15.319]);

b1 = v2 - v1
print b1
b2 = v3 - v2
print b2
b3 = v4 - v3
print b3
# u = ab ** cb
# v = db ** cb
# w = u ** v

n1 = np.cross(b1, b2);
n2 = np.cross(b2, b3);
print n1
print n2

m2 = norm(b2)
print m2

m1 = np.cross(n1, m2);
print m1
# n1_ = [ab[0] - 

# ]
# n2 = np.cross(db, cb);
# m1 = np.cross(n1, n2);
# print n1;
# print n2;
# print m1;
# # y = 
# y = m1 * n2
# # print cross2
# # print math.atan2(cross2, cross1)
# a = math.sqrt(sum([ x**2 for x in n1]));
# b = math.sqrt(sum([ x**2 for x in n2]));
# print np.dot(n1, n2) / (a*b)
# # print sum([ x**2 for x in m1]);