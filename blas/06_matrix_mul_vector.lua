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

m = torch.Tensor({{1, 2},
                  {3, 4},
                  {5, 6},
                  {7, 8}})

v = torch.Tensor({1, 2})

print("Original matrix")
print(m)

print("Original vector")
print(v)

m2 = torch.mv(m, v)
m3 = m * v

print("New matrix")
print(m2)
print(m3)
