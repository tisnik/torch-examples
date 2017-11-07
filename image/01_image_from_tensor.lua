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


img = createImageWithGrid(SIZE, GRID)

image.save("grid.png", img)
