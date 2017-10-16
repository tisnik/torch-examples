t = torch.Tensor(4,4,4)

s = t:storage()

for i = 1,s:size() do
    s[i]=i
end

print(t)

print(t:select(1, 1))
print(t:select(1, 4))

print(t:select(2, 1))
print(t:select(2, 4))

print(t:select(3, 1))
print(t:select(3, 4))

print(t[1])
print(t[4])

print(t:isContiguous())
print(t:select(1,1):isContiguous())
print(t:select(2,1):isContiguous())
print(t:select(3,1):isContiguous())
