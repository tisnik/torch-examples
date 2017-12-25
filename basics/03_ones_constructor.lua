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


-- tenzor obsahující jediný prvek nastavený na hodnotu 1
o0 = torch.ones(1)
print(o0)

-- tenzor obsahující deset prvků nastavených na hodnotu 1
o1 = torch.ones(10)
print(o1)

-- dvourozměrný tenzor 3x4 prvky
o2 = torch.ones(3,4)
print(o2)

-- trojrozměrny tenzor 2x3x4 prvky
o3 = torch.ones(2,3,4)
print(o3)
