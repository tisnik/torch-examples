x = torch.Tensor(5,5)

s = x:storage()

for i = 1,s:size() do
    s[i]=i
end

print(x)

print(x[ {{2,4}} ])
print(x[ {{2,4}, {3,5}} ])
print(x[ {{3}, {3}} ])

x[ {{1,4}, {1,4}} ] = 0

print(x)

x[ {{}, {2}} ] = 9

print(x)
