t = torch.Tensor(4,4,4)
s = t:storage()

for i = 1,s:size() do
    s[i] = i
end

print(t)

print(t:narrow(1,2,2))

print(t:narrow(2,2,2))

print(t:narrow(3,2,2))

print(t:narrow(1,3,1))

print(t:narrow(2,3,1))

print(t:narrow(3,3,1))
