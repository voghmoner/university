import math

s_blue = [[31, 9], [16, 52], [1, 86]]




def entropy(list):
    E = 0
    E_ = 0
    entry_all = 0
    length = sum([sum(x) for x in list])
    for j in list:
        entry = sum(j)
        for i in j:
            if i == 0:
                E = 0
                break
            p_i = float(i) / float(entry)
            # print p_i
            E += -1 * p_i * (math.log(p_i) / math.log(2))
            # print E
        E_ += (float(entry)/float(length)) * round(E, 3)
        # print E_
        E = 0
        entry = 0
    print E_


entropy(s_blue)
