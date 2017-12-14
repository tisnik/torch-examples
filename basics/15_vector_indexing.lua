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

v1 = torch.range(1, 10)
print(v1)

print(v1[{ {3,8} }])
print(v1[{ {5,5} }])

v1[{ {3,8} }] =0
print(v1)

print(v1:isContiguous())
print(v1[{ {3,8} }]:isContiguous())
