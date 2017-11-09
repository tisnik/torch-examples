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

vector = torch.Tensor(10)
storage = vector:storage()

for i = 1,storage:size() do
    storage[i] = 1.0/i
end

print(vector)

print(vector:sub(2,9))

print(vector:sub(2,-2))

print(vector:sub(10,10))

print(vector:sub(-1,-1))
