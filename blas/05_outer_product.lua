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

v1 = torch.Tensor({1,0,0})
v2 = torch.Tensor({0,1,0})

print("Original vector 1")
print(v1)

print("Original vector 2")
print(v2)

v3 = torch.ger(v1, v2)

print("Outer products")
print(v3)

print("---------------")

v1 = torch.Tensor({1,2,3})
v2 = torch.Tensor({1,2,3})

print("Original vector 1")
print(v1)

print("Original vector 2")
print(v2)

v3 = torch.ger(v1, v2)

print("Outer products")
print(v3)

print("---------------")

v1 = torch.range(1,10)
v2 = torch.Tensor({1,2,3})

print("Original vector 1")
print(v1)

print("Original vector 2")
print(v2)

v3 = torch.ger(v1, v2)

print("Outer products")
print(v3)

