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

function writeObject(filename, object)
    fout = torch.DiskFile(filename, "w")
    fout:writeObject(object)
    fout:close()
end

writeObject("nil.asc", nil)
writeObject("true.asc", true)
writeObject("false.asc", false)

answer = 42
writeObject("answer.asc", answer)

writeObject("pi.asc", math.pi)

greeting = "Hello world!"
writeObject("greeting.asc", greeting)

empty_array = {}
writeObject("empty_array.asc", empty_array)

array = {1,2,3}
writeObject("array.asc", array)

array2 = {"xx", "yy", "zz"}
writeObject("array2.asc", array2)

dict = {x=1, y=2, z=3}
writeObject("dict.asc", dict)
