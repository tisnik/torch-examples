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
    local fout = torch.DiskFile(filename, "w")
    fout:writeObject(tensor)
    fout:close()
end

function readTensor(filename)
    local fin = torch.DiskFile(filename, "r")
    return fin:readObject()
    -- no fin:close() is needed here
end

function printTensorInfo(tensor)
    print("Size:")
    print(tensor:size())
    print("Elements:")
    print(tensor:nElement())
    print("Dimensions:")
    print(tensor:dim())
    print("Stride:")
    print(tensor:stride())
    print("Storage offset:")
    print(tensor:storageOffset())
end

v = torch.range(1, 24)
q = v:resize(3, 2, 2, 2)
print(q)
writeTensor("tensor_3_2.asc", q)

deserialized = readTensor("tensor_3_2.asc")
print(deserialized)

printTensorInfo(q)
printTensorInfo(deserialized)
