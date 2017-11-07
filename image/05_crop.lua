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

image.save("cropped1.png", image1crop)
image.save("cropped2.png", image2crop)

image1cropCenter = image.crop(image1, "c", 200, 100)
image2cropCenter = image.crop(image2, "c", 200, 100)

image.save("cropped1center.png", image1cropCenter)
image.save("cropped2center.png", image2cropCenter)

