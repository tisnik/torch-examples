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

r1 = torch.range(1, 10)
print(r1)

r2 = torch.range(1, 10, 2)
print(r2)

r3 = torch.range(10, 0, -2)
print(r3)

r4 = torch.range(10, 0, 0)
print(r4)

