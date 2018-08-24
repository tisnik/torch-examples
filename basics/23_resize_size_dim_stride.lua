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

v = torch.range(1, 24)
printTensorInfo(v)

m1 = v:resize(4, 6)
printTensorInfo(m1)

m2 = v:resize(6, 4)
printTensorInfo(m2)

t1 = v:resize(2, 3, 4)
printTensorInfo(t1)

t2 = v:resize(3, 2, 4)
printTensorInfo(t2)

t3 = v:resize(3, 4, 2)
printTensorInfo(t3)

t4 = v:resize(2, 2, 2, 3)
printTensorInfo(t4)

t5 = v:resize(3, 2, 2, 2)
printTensorInfo(t5)
