t = torch.Tensor(4,4,4)

s = t:storage()

for i = 1,s:size() do
    s[i]=i
end

print(t)

print(t[ {{2,3}} ])
print(t[ {{2,3},{3,4}} ])
print(t[ {{2,3},{3,4},{1}} ])

print(t[ {{1},{2},{3}} ])

print(t[ {{4},{3},{2}} ])
