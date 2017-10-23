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
m1 = v:resize(6, 4)
print(m1)

print("---------------------------")

indexes = torch.LongTensor({{1,1,1,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(1, indexes))

indexes = torch.LongTensor({{1},{1},{1},{1},{1},{1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(2, indexes))

print("---------------------------")

indexes = torch.LongTensor({{1,1,1,1}, {2,2,2,2}, {3,3,3,3}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(1, indexes))

indexes = torch.LongTensor({{1,2,1,2}, {2,1,2,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(1, indexes))

indexes = torch.LongTensor({{6,6,6,6}, {5,5,5,5}, {4,4,4,4}, {3,3,3,3}, {2,2,2,2}, {1,1,1,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(1, indexes))

print("---------------------------")

indexes = torch.LongTensor({{1,1}, {2,2}, {3,3}, {4,4}, {1,1}, {1,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(2, indexes))

indexes = torch.LongTensor({{1,1}, {2,2}, {3,3}, {4,4}, {1,1}, {1,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(2, indexes))

indexes = torch.LongTensor({{1,4}, {1,4}, {1,4}, {4,1}, {4,1}, {4,1}})
print("Indexes:")
print(indexes)
print("Result:")
print(m1:gather(2, indexes))

