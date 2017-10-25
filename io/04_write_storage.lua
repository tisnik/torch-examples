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

function writeTensorStorage(filename, tensor)
    local fout = torch.DiskFile(filename .. ".asc", "w"):ascii()
    local elements = tensor:nElement()
    local storage = tensor:storage()
    local written = fout:writeInt(storage)
    fout:close()
    print("Written " .. written .. " element(s)")

    local fout = torch.DiskFile(filename .. ".bin", "w"):binary()
    local elements = tensor:nElement()
    local storage = tensor:storage()
    local written = fout:writeInt(storage)
    fout:close()
    print("Written " .. written .. " element(s)")
end

s1 = torch.Tensor(1):int()
s1[1] = 42
print(s1)
writeTensorStorage("scalar_1", s1)

s2 = torch.Tensor({42}):int()
print(s2)
writeTensorStorage("scalar_2", s2)

v1 = torch.Tensor(3):int()
v1[1] = 10
v1[2] = 20
v1[3] = 30
print(v1)
writeTensorStorage("vector1", v1)

v2 = torch.Tensor({10,20,30}):int()
print(v2)
writeTensorStorage("vector2", v2)

m = torch.Tensor({{10,20,30}, {40,50,60}, {70,80,90}}):int()
print(m2)
writeTensorStorage("matrix", m)

v = torch.range(1, 24):int()
q = v:resize(3, 2, 2, 2)
print(q)
writeTensorStorage("tensor_3", q)
