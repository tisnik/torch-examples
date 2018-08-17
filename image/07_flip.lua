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

require("image")


SIZE = 256
GRID = 16

original_image_address = "https://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png"
image_name = "lenna.png"


function file_exists(filename)
    local fin = io.open(filename,"r")
    if fin then
        io.close(fin)
        return true
    else
        return false
    end
end


function download_file(address, filename)
    local command = "wget -v -O " .. filename .. " " .. address
    os.execute(command)
end


function setup(address, filename)
    if not file_exists(filename) then
        download_file(original_image_address, filename)
    end
end


setup(original_image_address, image_name)

lenna = image.load(image_name)

hflip = image.hflip(lenna)
image.save("horizontal_flip.png", hflip)

vflip = image.vflip(lenna)
image.save("vertical_flip.png", vflip)

flip_d1 = image.flip(lenna, 1)
image.save("flip_dimension1.png", flip_d1)

flip_d2 = image.flip(lenna, 2)
image.save("flip_dimension2.png", flip_d2)

flip_d3 = image.flip(lenna, 3)
image.save("flip_dimension3.png", flip_d3)

