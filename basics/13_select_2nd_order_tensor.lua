x = torch.Tensor(5,5)

s = x:storage()

for i = 1,s:size() do
    s[i]=i
end

print(x)

print(x:select(1, 1))
print(x:select(1, 5))
print(x:select(2, 1))
print(x:select(2, 5))

print(x[1])
print(x[5])

print(x:isContiguous())
print(x:select(1,1):isContiguous())
print(x:select(1,5):isContiguous())
print(x:select(2,1):isContiguous())
print(x:select(2,5):isContiguous())
print(x[1]:isContiguous())
