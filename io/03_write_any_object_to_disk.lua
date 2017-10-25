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
    local fout = torch.DiskFile(filename .. ".asc", "w"):ascii()
    fout:writeObject(object)
    fout:close()

    local fout = torch.DiskFile(filename .. ".bin", "w"):binary()
    fout:writeObject(object)
    fout:close()
end

writeObject("nil", nil)
writeObject("true", true)
writeObject("false", false)

answer = 42
writeObject("answer", answer)

writeObject("pi", math.pi)

greeting = "Hello world!"
writeObject("greeting", greeting)

empty_array = {}
writeObject("empty_array", empty_array)

array = {1,2,3}
writeObject("array", array)

array2 = {"xx", "yy", "zz"}
writeObject("array2", array2)

dict = {x=1, y=2, z=3}
writeObject("dict", dict)
