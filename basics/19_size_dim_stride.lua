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

v = torch.range(1, 10)
m = torch.Tensor(5, 6)
t3 = torch.Tensor(4, 5, 6)
t4 = torch.Tensor(2, 3, 4, 5)

printTensorInfo(v)
printTensorInfo(m)
printTensorInfo(t3)
printTensorInfo(t4)

printTensorInfo(v[{ {5,8} }])
printTensorInfo(m[{ {1,1},{1,1} }])
printTensorInfo(m[{ {2,2},{2,2} }])
