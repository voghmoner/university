'010 0110',
'000 0111',
'110 0010',
'010 0100',
'100 1111',
'010 1011',
'110 0 111',
'101 1 111',
'010 1 111',
'100 1 011',
'010 0 010',
'000 0 010',
'111 0 110',
'100 1 000',
'111 0 110',
'011 1 001',
'110 0 100',
'000 0 101',
'110 0 111',
'001 0 010',
'110 1 110',
'111 1 101',
'000 0 111',
'100 0 010']
for code in error_code:
    b = list(code)
    b = map(int, b)
    p1 = b[0] ^ b[2] ^ b[6] ^ b[4]
    p2 = b[3] ^ b[4] ^ b[5] ^ b[6]
    p3 = b[1] ^ b[6] ^ b[2] ^ b[5]
    # print p1, p2, p3
    c1 = p1 + p2
    c2 = p1 + p3
    c3 = p2 + p3
    print b
    if(p1 == 1 and p2 == 1 and p3 == 1):
        b[6] = ~b[6] + 2
    elif (c1 == 2 or c2 == 2 or c3 == 2):
        if c1 % 2 == 0:
            b[4] = ~b[4] + 2
        elif c2 % 2 == 0:
            b[2] = ~b[2] + 2
        else:
            b[5] = ~b[5] + 2
    else:
        if p1 == 1:
            b[0] = ~b[0] + 2
        elif p2 == 1:
            b[3] = ~b[3] + 2
        elif p3 == 1:
            b[1] = ~b[1] + 2
    # elif (1 == p1 or p2 == 1) and not(1 == p1 or p3 == 1) \
    #     and not(1 == p2 or p3 == 1) or (1 == p1 or p3 == 1) and \
    #     not(1 == p1 or p2 == 1) and not(1 == p2 or p3 == 1) or \
    #     (1 == p2 or p3 == 1) and not(1 == p1 or p2 == 1) \
    #     and not(1 == p1 or p3 == 1) :
    #      print 'yay: ', b
    print b
    print chr(int(''.join(str(el) for el in b), 2))
    # print chr(int('1100011', 2))
    # print ''.join(str(el) for el in b)
