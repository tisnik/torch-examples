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

trans_identity = torch.eye(3, 3)

angle = math.pi/6

trans_rotation = torch.Tensor({{math.cos(angle), -math.sin(angle), 0},
                               {math.sin(angle),  math.cos(angle), 0},
                               {0,                0,               1}})

v = torch.Tensor({1, 0, 1})

print("Original vector")
print(v)

v = trans_identity * v

print("After transformation #1")
print(v)

v = trans_rotation * v

print("First rotation by 30")
print(v)

v = trans_rotation * v

print("Second rotation by 30°")
print(v)

print("Third rotation by 30°")
v = trans_rotation * v

print(v)
