x=torch.Tensor(4,5)

s=x:storage()

for i=1,s:size() do
    s[i]=i
end

print(x)

print(x[{2}])
print(x[{2, {2,-2}}])
print(x[{{2,-2}, {2,-2}}])

print(x[{{2,-2}, {}}])

print(x[{{}, {}}])
