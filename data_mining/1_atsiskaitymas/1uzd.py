# http://www.saedsayad.com/decision_tree.htm

import math

s = [[47, 70], [1, 77]]


def sum_p (probabilities):
    return sum(probabilities)

def p(x, all):
    return round(float(x) / float(all), 6)



def entropy(list):
    E = 0
    E_ = 0
    entry_all = 0
    # length = sum([sum(x) for x in list])
    for p_i in list:
        if p_i == 0:
            E = 0
            break
        # p_i = float(i) / float(entry)
        # print p_i
        E += p_i * (math.log(1/p_i) / math.log(2))
    return round(E, 6)

def entropy_cond(list, length):
    E = 0
    # length = sum([sum(x) for x in list])
    for p_i in list:
        if p_i == 0:
            E = 0
            break
        E += p_i * entropy()
    return E

le = sum([sum(x) for x in s])
# entropy(s_blue)
p_10 = p(s[0][0], le)
p_11 = p(s[0][1], le)
p_20 = p(s[1][0], le)
p_21 = p(s[1][1], le)
sum_p1 = sum([p_10, p_11])
sum_p2 = sum([p_20, p_21])
sum_p_0 = sum([p_10, p_20])
sum_p_1 = sum([p_11, p_21])

print p(s[0][0], le), p(s[0][1], le)
print p(s[1][0], le), p(s[1][1], le)
print sum_p1
print sum_p2
print sum_p_0, sum_p_1

h_y = entropy([sum_p_0, sum_p_1])
h_x = entropy([sum_p1, sum_p2])
h_xy = entropy([p_10, p_11, p_20, p_21])
I_xy = h_x + h_y - h_xy
print h_y
print h_x
print h_xy
print I_xy
