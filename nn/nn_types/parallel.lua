require("nn")


function construct_1st_parallel_neural_network()
    -- tenzor se rozdeli podle prvni dimenze
    -- vysledky se spoji taktez podle prvni dimenze
    local network = nn.Parallel(1,1)

    -- jedina vrstva neuronu, provadi se paralelne s vrstvou nize
    network:add(nn.Linear(3, 1))

    -- jedina vrstva neuronu, provadi se paralelne s vrstvou vyse
    network:add(nn.Linear(3, 1))

    return network
end


function construct_2nd_parallel_neural_network()
    -- tenzor se rozdeli podle druhe dimenze
    -- vysledky se spoji taktez podle prvni dimenze
    local network = nn.Parallel(2,1)

    -- jedina vrstva neuronu, provadi se paralelne s vrstvami nize
    network:add(nn.Linear(2, 1))

    -- jedina vrstva neuronu, provadi se paralelne s vrstvou vyse a nize
    network:add(nn.Linear(2, 1))

    -- jedina vrstva neuronu, provadi se paralelne s vrstvami vyse
    network:add(nn.Linear(2, 1))

    return network
end


-- nejprve si znovu ukazeme metodu select
input = torch.Tensor({{1,2,3}, {4,5,6}})

print("Vstup:")
print(input)

-- vyber prvku pres prvni dimenzi
print("select(1,1):")
print(input:select(1,1))
print("select(1,2):")
print(input:select(1,2))

-- vyber prvku pres druhou dimenzi
print("select(2,1):")
print(input:select(2,1))
print("select(2,2):")
print(input:select(2,2))
print("select(2,3):")
print(input:select(2,3))

-- prvni typ neuronove site
network = construct_1st_parallel_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({{1,2,3}, {4,5,6}})))
print()

-- druhy typ neuronove site
network = construct_2nd_parallel_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({{1,2,3}, {4,5,6}})))
print()

