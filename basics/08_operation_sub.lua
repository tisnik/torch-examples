x=torch.Tensor(4,5)

s=x:storage()

for i=1,s:size() do
    s[i]=i
end

print(x)

print(x:sub(1,4))
print(x:sub(1,3))
print(x:sub(2,3))

print(x:sub(2,3,2,3))

print(x:sub(-2,-1))
print(x:sub(-2,-1,-2,-1))
