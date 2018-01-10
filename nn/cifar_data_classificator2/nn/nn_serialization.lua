FILENAME = "neural_network.asc"

function serialize_nn(network)
    local fout = torch.DiskFile(FILENAME, "w"):ascii()
    fout:writeObject(network)
    fout:close()
end

function deserialize_nn()
    local fin = torch.DiskFile(FILENAME, "r")
    return fin:readObject()
end
