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

x = torch.Tensor(5,5)

s = x:storage()

for i = 1,s:size() do
    s[i]=i
end

print(x)

print(x[ {{2,4}} ])
print(x[ {{2,4}, {3,5}} ])
print(x[ {{3}, {3}} ])

x[ {{1,4}, {1,4}} ] = 0

print(x)

x[ {{}, {2}} ] = 9

print(x)
