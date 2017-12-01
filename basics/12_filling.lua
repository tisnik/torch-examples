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

x=torch.zeros(5,5)
print(x)

x:sub(2,4,2,4):fill(1)
print(x)



x=torch.zeros(5,5)
print(x)

x:narrow(1,3,1):fill(9)
x:narrow(2,5,1):fill(3)
print(x)



x=torch.zeros(7,7)
print(x)

x:narrow(1,3,4):narrow(2,2,2):fill(1)
print(x)

