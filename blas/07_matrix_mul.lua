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

m1 = torch.Tensor({{1, 2, 3},
                   {4, 5, 6},
                   {7, 8, 9}})

m2 = torch.eye(3,3)

m3 = torch.eye(3,3)
m3[{2 ,2}] = 10

print("Original matrix 1")
print(m1)

print("Original matrix 2")
print(m2)

print("Original matrix 3")
print(m3)

m12 = m1 * m2

print("m1 x m2:")
print(m12)

m13 = m1 * m3

print("m1 x m3:")
print(m13)
