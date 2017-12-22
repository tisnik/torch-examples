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


-- první varianta kontrukce tenzoru
s1 = torch.Tensor(1)
s1[1] = 42
print(s1)


-- druhá varianta konstrukce tenzoru
s2 = torch.Tensor({42})
print(s2)


-- tenzor ve funkci vektoru se třemi prvky
v1 = torch.Tensor(3)
v1[1] = 10
v1[2] = 20
v1[3] = 30
print(v1)


-- alternativní konstrukce z tabulky
v2 = torch.Tensor({10,20,30})
print(v2)


-- tenzor ve funkci matice
m1 = torch.Tensor(3,3)
print(m1)


-- alternativní konstrukce z tabulky
m2 = torch.Tensor({{1,2,3}, {4,5,6}, {7,8,9}})
print(m2)


-- čtyřrozměrná struktura
q = torch.Tensor({{{1,2,3}, {4,5,6}, {7,8,9}},
                  {{9,8,7}, {6,5,4}, {3,2,1}}})
print(q)
