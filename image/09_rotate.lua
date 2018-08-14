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


function print_image_info(img)
    print("Element type:")
    print(img:type())

    print("Dimensions:")
    print(img:dim())

    print("Tensor shape:")
    print(img:size())
end


function createImageWithGrid(size, grid)
    img=torch.Tensor(SIZE, SIZE)
    img:fill(255)

    for row = 1, SIZE-1, GRID do
        img:narrow(1, row, 1):zero()
        img:narrow(1, row+1, 1):zero()
    end

    for column = 1, SIZE-1, GRID do
        img:narrow(2, column, 1):zero()
        img:narrow(2, column+1, 1):zero()
    end

    return img
end


setup(original_image_address, image_name)

lenna = image.load(image_name)

angle5 = math.rad(5)
angle45 = math.rad(45)

rotated5_simple = image.rotate(lenna, angle5, "simple")
rotated5_bilinear = image.rotate(lenna, angle5, "bilinear")

rotated45_simple = image.rotate(lenna, angle45, "simple")
rotated45_bilinear = image.rotate(lenna, angle45, "bilinear")

image.save("rotated5_simple.png", rotated5_simple)
image.save("rotated5_bilinear.png", rotated5_bilinear)

image.save("rotated45_simple.png", rotated45_simple)
image.save("rotated45_bilinear.png", rotated45_bilinear)

grid = createImageWithGrid(SIZE, GRID)

rotated5_simple = image.rotate(grid, angle5, "simple")
rotated5_bilinear = image.rotate(grid, angle5, "bilinear")

rotated45_simple = image.rotate(grid, angle45, "simple")
rotated45_bilinear = image.rotate(grid, angle45, "bilinear")

image.save("grid_rotated5_simple.png", rotated5_simple)
image.save("grid_rotated5_bilinear.png", rotated5_bilinear)

image.save("grid_rotated45_simple.png", rotated45_simple)
image.save("grid_rotated45_bilinear.png", rotated45_bilinear)

