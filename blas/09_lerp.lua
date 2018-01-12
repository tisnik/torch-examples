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

v1 = torch.Tensor({100, 0, 0, 0, 0})
v2 = torch.range(0, 4)

print("Source vector 1")
print(v1)

print("Source vector 2")
print(v2)

for weight = 0.0, 1.0, 0.2 do
    print("Linear interpolation with weight=" .. weight)
    local vt = torch.lerp(v1, v2, weight)
    print(vt)
end
