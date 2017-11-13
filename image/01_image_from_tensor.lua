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


function createImageWithGrid(size, grid)
    img=torch.Tensor(SIZE, SIZE)
    img:fill(255)

    for row = 1, SIZE, GRID do
        img:narrow(1, row, 1):zero()
    end

    for column = 1, SIZE, GRID do
        img:narrow(2, column, 1):zero()
    end

    return img
end


function createRGBImage(size)
    img = torch.Tensor(3, size, size)

    line = torch.linspace(0, 1, size)

    red = line:repeatTensor(size):reshape(size, size)
    green = torch.zeros(size, size)
    blue = red:transpose(1, 2)

    img[1] = red
    img[2] = green
    img[3] = blue

    return img
end



img = createImageWithGrid(SIZE, GRID)

image.save("grid.png", img)


img2 = createRGBImage(SIZE)

image.save("rgb.png", img2)

