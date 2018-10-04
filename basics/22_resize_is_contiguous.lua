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

v = torch.range(1, 24)
print(v:isContiguous())

m1 = v:resize(4, 6)
print(m1:isContiguous())

m2 = v:resize(6, 4)
print(m2:isContiguous())

t1 = v:resize(2, 3, 4)
print(t1:isContiguous())

t2 = v:resize(3, 2, 4)
print(t2:isContiguous())

t3 = v:resize(3, 4, 2)
print(t3:isContiguous())

t4 = v:resize(2, 2, 2, 3)
print(t4:isContiguous())

t5 = v:resize(3, 2, 2, 2)
print(t5:isContiguous())
