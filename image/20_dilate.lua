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
require("gnuplot")


SIZE = 256
GRID = 16
BORDER = 100


function createImageWithGrid(size, grid, border)
    img=torch.Tensor(size, size)
    img:fill(1)

    for row = border, size-border, grid do
        img:narrow(1, row, 1):zero()
    end

    for column = border, size-border, grid do
        img:narrow(2, column, 1):zero()
    end

    return img
end


source = createImageWithGrid(SIZE, GRID, BORDER)

for i=1,5 do
    eroded = image.erode(source)
    source = eroded
end

for i=1,7 do
    dilated = image.dilate(source)
    image.save("dilated" .. i .. ".png", dilated)
    source = dilated
end

