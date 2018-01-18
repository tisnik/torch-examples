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

m1 = torch.zeros(5, 5)
m2 = torch.range(0, 25):resize(5,5)

print("Source matrix 1")
print(m1)

print("Source matrix 2")
print(m2)

for weight = 0.0, 1.0, 0.2 do
    print("Linear interpolation with weight=" .. weight)
    local mt = torch.lerp(m1, m2, weight)
    print(mt)
end
