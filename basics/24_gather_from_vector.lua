v1 = torch.range(10, 100, 10)
print(v1)

indexes = torch.LongTensor({2, 4, 6, 8, 10})
print(indexes)

print(v1:gather(1, indexes))

v = torch.range(1, 24)
m1 = v:resize(6, 4)
print(m1)

indexes = torch.LongTensor({{1,1,1,1}, {2,2,2,2}, {3,3,3,3}})
print(indexes)
print(m1:gather(1, indexes))

indexes = torch.LongTensor({{1,2,1,2}, {2,1,2,1}})
print(indexes)
print(m1:gather(1, indexes))

indexes = torch.LongTensor({{6,6,6,6}, {5,5,5,5}, {4,4,4,4}, {3,3,3,3}, {2,2,2,2}, {1,1,1,1}})
print(indexes)
print(m1:gather(1, indexes))
