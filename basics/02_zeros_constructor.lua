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

x1 = torch.Tensor(10):zero()
print(x1)

x2 = torch.Tensor(4,4):zero()
print(x2)

z0 = torch.zeros(1)
print(z0)

z1 = torch.zeros(10)
print(z1)

z2 = torch.zeros(3,4)
print(z2)

z3 = torch.zeros(2,3,4)
print(z3)
