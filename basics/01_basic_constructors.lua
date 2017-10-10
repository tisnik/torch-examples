s1 = torch.Tensor(1)
s1[1] = 42
print(s1)

s2 = torch.Tensor({42})
print(s2)

v1 = torch.Tensor(3)
v1[1] = 10
v1[2] = 20
v1[3] = 30
print(v1)

v2 = torch.Tensor({10,20,30})
print(v2)

m1 = torch.Tensor(3,3)
print(m1)

m2 = torch.Tensor({{1,2,3}, {4,5,6}, {7,8,9}})
print(m2)

q = torch.Tensor({{{1,2,3}, {4,5,6}, {7,8,9}},
                  {{9,8,7}, {6,5,4}, {3,2,1}}})
print(q)
