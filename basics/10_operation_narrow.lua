vector = torch.Tensor(10)
storage = vector:storage()

for i = 1,storage:size() do
    storage[i] = 1.0/i
end

print(vector)

print(vector:narrow(1,2,3))
print(vector:narrow(1,1,5))

------------------------------

x=torch.Tensor(4,5)

s=x:storage()

for i=1,s:size() do
    s[i]=i
end

print(x)

print(x:narrow(1,2,2))

print(x:narrow(2,2,2))
