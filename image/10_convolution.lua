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


function convoluteAndSaveImage(source_image, kernel, filename)
    target_image = image.convolve(source_image, kernel)
    print("Applying the following kernel to create " .. filename)
    print(kernel)
    image.save(filename, target_image)
end


setup(original_image_address, image_name)

lenna = image.load(image_name)



kernel = torch.Tensor({{ 1, 1, 1},
                       { 1, 1, 1},
                       { 1, 1, 1}})

kernel = kernel / torch.sum(kernel)

convoluteAndSaveImage(lenna, kernel, "box_blur_3x3.png")



kernel = torch.Tensor(5, 5)
kernel:fill(1)

kernel = kernel / torch.sum(kernel)

convoluteAndSaveImage(lenna, kernel, "box_blur_5x5.png")



kernel = torch.Tensor({{ 1, 2, 1},
                       { 2, 4, 2},
                       { 1, 2, 1}})

kernel = kernel / torch.sum(kernel)

convoluteAndSaveImage(lenna, kernel, "gaussian_blur.png")



kernel = torch.Tensor({{ 0,-1, 0},
                       {-1, 5,-1},
                       { 0,-1, 0}})

convoluteAndSaveImage(lenna, kernel, "sharpen.png")



kernel = torch.Tensor({{-1,-1,-1},
                       {-1, 8,-1},
                       {-1,-1,-1}})

convoluteAndSaveImage(lenna, kernel, "edge_detect.png")



kernel = torch.Tensor({{ 1, 2, 1},
                       { 0, 0, 0},
                       {-1,-2,-1}})

convoluteAndSaveImage(lenna, kernel, "sobel.png")



kernel = torch.Tensor({{-1, 1}})

convoluteAndSaveImage(lenna, kernel, "vertical_edge_detect.png")



kernel = torch.Tensor({{-1},
                       { 1}})

convoluteAndSaveImage(lenna, kernel, "horizontal_edge_detect.png")
