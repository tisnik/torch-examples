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


function print_image_info(img)
    print("Element type:")
    print(img:type())

    print("Dimensions:")
    print(img:dim())

    print("Tensor shape:")
    print(img:size())
end


setup(original_image_address, image_name)

image1 = image.load(image_name)
image2 = image.load(image_name, 1)

image1crop = image.crop(image1, 200, 150, 400, 350)
image2crop = image.crop(image2, 200, 150, 400, 350)

print_image_info(image1crop)
print_image_info(image2crop)

image.save("cropped1box.png", image1crop)
image.save("cropped2box.png", image2crop)


function cropAndSaveImage(source, format, width, height, order)
    croppedImage = image.crop(source, format, width, height)
    filename = "cropped" .. order .. format .. ".png"
    print(filename)
    print_image_info(croppedImage)
    image.save(filename, croppedImage)
end

formats = {"c", "tl", "tr", "bl", "br"}

for _, format in ipairs(formats) do
    cropAndSaveImage(image1, format, 250, 150, 1)
    cropAndSaveImage(image2, format, 250, 150, 2)
end

