--
--  (C) Copyright 2017  Pavel Tisnovsky
--
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the Eclipse Public License v1.0
--  which accompanies this distribution, and is available at
--  http://www.eclipse.org/legal/epl-v10.html
--
--  Contributors:
--      Pavel Tisnovsky
--

function writeTensor(filename, tensor)
    local fout = torch.DiskFile(filename .. ".asc", "w"):ascii()
    fout:writeObject(tensor)
    fout:close()

    local fout = torch.DiskFile(filename .. ".bin", "w"):binary()
    fout:writeObject(tensor)
    fout:close()
end

s1 = torch.Tensor(1)
s1[1] = 42
print(s1)
writeTensor("scalar_1", s1)

s2 = torch.Tensor({42})
print(s2)
writeTensor("scalar_2", s2)

v1 = torch.Tensor(3)
v1[1] = 10
v1[2] = 20
v1[3] = 30
print(v1)
writeTensor("vector1", v1)

v2 = torch.Tensor({10,20,30})
print(v2)
writeTensor("vector2", v2)

m = torch.Tensor({{10,20,30}, {40,50,60}, {70,80,90}})
print(m2)
writeTensor("matrix", m)

v = torch.range(1, 24)
q = v:resize(3, 2, 2, 2)
print(q)
writeTensor("tensor_3", q)
