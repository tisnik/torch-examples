x=torch.zeros(5,5)
print(x)

x:sub(2,4,2,4):fill(1)
print(x)



x=torch.zeros(5,5)
print(x)

x:narrow(1,3,1):fill(9)
x:narrow(2,5,1):fill(3)
print(x)



x=torch.zeros(7,7)
print(x)

x:narrow(1,3,4):narrow(2,2,2):fill(1)
print(x)

