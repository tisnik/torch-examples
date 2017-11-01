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

v1 = torch.Tensor({1,2,3})
v2 = torch.Tensor({1,2,3})

print("Original vector 1")
print(v1)

print("Original vector 2")
print(v2)

v3 = torch.mul(v1, 10)
v4 = v2:mul(10)

print("Results of vector*scalar")
print(v3)
print(v4)

print("New value of vector 1")
print(v1)

print("New value of vector 2")
print(v2)
