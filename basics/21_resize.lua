v = torch.range(1, 24)
print(v)

m1 = v:resize(4, 6)
print(m1)

m2 = v:resize(6, 4)
print(m2)

t1 = v:resize(2, 3, 4)
print(t1)

t2 = v:resize(3, 2, 4)
print(t2)

t3 = v:resize(3, 4, 2)
print(t3)

t4 = v:resize(2, 2, 2, 3)
print(t4)

t5 = v:resize(3, 2, 2, 2)
print(t5)
