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

vx = torch.range(1, 11)
vy = torch.pow(vx-6, 2)

print(vx)
print(vy)

vx = torch.range(0, 360, 10)
vy = torch.sin(vx/180.0*math.pi)

print(vx)
print(vy)
