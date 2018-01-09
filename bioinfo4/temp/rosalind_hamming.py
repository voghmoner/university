with open("hamming_data1.txt") as f:
	data = f.readlines()

data = [x.strip() for x in data]
print len(data[0]), len(data[1])

count = 0
for i, j in zip(data[0], data[1]):
	if i != j:
		count += 1

print count