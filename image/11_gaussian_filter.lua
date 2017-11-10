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


function convoluteAndSaveImage(source_image, size, sigma, filename)
    kernel = image.gaussian(size, sigma, 1, true)
    target_image = image.convolve(source_image, kernel)
    print("Applying the following kernel to create " .. filename)
    print(kernel)
    image.save(filename, target_image)
end


setup(original_image_address, image_name)

lenna = image.load(image_name)

sizes = {3, 5, 7}
sigmas = {0.1, 0.2, 1.1}

for _, size in ipairs(sizes) do
    for __, sigma in ipairs(sigmas) do
        filename = "gaussian_" .. size .. "x" .. size .. "_sigma_" .. sigma .. ".png"
        convoluteAndSaveImage(lenna, size, sigma, filename)
    end
end
