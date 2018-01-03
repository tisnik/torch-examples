original_data_address = "https://s3.amazonaws.com/torch7/data/cifar10torchsmall.zip"
zip_file_name = "cifar10torchsmall.zip"


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


function unzip_file(filename)
    local command = "unzip " .. filename
    os.execute(command)
end


function setup_cifar_dataset(address, filename)
    if not file_exists(filename) then
        download_file(address, filename)
    end
    if not file_exists("cifar10-test.t7") or
       not file_exists("cifar10-train.t7") then
        unzip_file(filename)
    end
end


--setup(original_data_address, "cifar10torchsmall.zip")
