v = torch.range(-5, 5)
print(v)

v2 = v:type("torch.ByteTensor")
print(v2)

v3 = v:type("torch.CharTensor")
print(v3)

v4 = v:type("torch.ShortTensor")
print(v4)

v5 = v:type("torch.IntTensor")
print(v5)

v6 = v:type("torch.FloatTensor")
print(v6)

print("--------------------------")

v2_ = v:byte()
print(v2_)

v3_ = v:char()
print(v3_)

v4_ = v:short()
print(v4_)

v5_ = v:int()
print(v5_)

v6_ = v:float()
print(v6_)
