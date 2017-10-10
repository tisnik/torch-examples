t = torch.Tensor(2,3,4)
s = t:storage()

for i = 1,s:size() do
    s[i] = i
end

print(s)

print(t)
