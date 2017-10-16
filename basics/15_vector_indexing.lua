v1 = torch.range(1, 10)
print(v1)

print(v1[{ {3,8} }])
print(v1[{ {5,5} }])

v1[{ {3,8} }] =0
print(v1)

print(v1:isContiguous())
print(v1[{ {3,8} }]:isContiguous())
