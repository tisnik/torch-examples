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

vx = torch.range(0, 10)
vy = torch.pow(vx, 2)

print(vx)
print(vy)

v = torch.range(-12, 13)
mx = v:resize(5, 5)
my = torch.abs(mx)
print(mx)
print(my)
