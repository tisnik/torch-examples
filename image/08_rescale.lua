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

cropped = image.crop(lenna, "c", 100, 66)

scaled_simple = image.scale(cropped, 600, 400, "simple")
scaled_bilinear = image.scale(cropped, 600, 400, "bilinear")
scaled_bicubic = image.scale(cropped, 600, 400, "bicubic")

print_image_info(scaled_simple)
print_image_info(scaled_bilinear)
print_image_info(scaled_bicubic)

image.save("scaled_simple.png", scaled_simple)
image.save("scaled_bilinear.png", scaled_bilinear)
image.save("scaled_bicubic.png", scaled_bicubic)

grid = createImageWithGrid(SIZE, GRID)

croppedGrid = image.crop(grid, "c", SIZE/4, SIZE/4)

scaled_simple = image.scale(croppedGrid, SIZE, SIZE, "simple")
scaled_bilinear = image.scale(croppedGrid, SIZE, SIZE, "bilinear")
scaled_bicubic = image.scale(croppedGrid, SIZE, SIZE, "bicubic")

image.save("grid_scaled_simple.png", scaled_simple)
image.save("grid_scaled_bilinear.png", scaled_bilinear)
image.save("grid_scaled_bicubic.png", scaled_bicubic)

