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

v1 = torch.range(1,5)
v2 = torch.range(1,5)

print("Original vector 1")
print(v1)

print("Original vector 2")
print(v2)

v3 = torch.dot(v1, v2)
v4 = v1 * v2
v5 = v1:dot(v2)

print("Dot products")
print(v3)
print(v4)
print(v5)

print("New value of vector 1")
print(v1)

print("New value of vector 2")
print(v2)
