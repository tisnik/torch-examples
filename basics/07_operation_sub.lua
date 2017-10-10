vector = torch.Tensor(10)
storage = vector:storage()

for i = 1,storage:size() do
    storage[i] = 1.0/i
end

print(vector)

print(vector:sub(2,9))

print(vector:sub(2,-2))

print(vector:sub(10,10))

print(vector:sub(-1,-1))
