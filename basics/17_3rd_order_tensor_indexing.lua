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

t = torch.Tensor(4,4,4)

s = t:storage()

for i = 1,s:size() do
    s[i]=i
end

print(t)

print(t[ {{2,3}} ])
print(t[ {{2,3},{3,4}} ])
print(t[ {{2,3},{3,4},{1}} ])

print(t[ {{1},{2},{3}} ])

print(t[ {{4},{3},{2}} ])
