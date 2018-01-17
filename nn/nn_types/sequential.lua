require("nn")


function construct_simplest_neural_network()
    local network = nn.Sequential()

    -- jedina vrstva neuronu
    network:add(nn.Linear(3, 5))

    return network
end


function construct_two_layers_neural_network()
    local network = nn.Sequential()

    -- prvni vrstva neuronu
    network:add(nn.Linear(3, 10))

    -- posledni vrstva neuronu
    network:add(nn.Linear(10, 5))

    return network
end


function construct_neural_network_with_nonlinear_functions()
    local network = nn.Sequential()

    -- prvni vrstva neuronu
    network:add(nn.Linear(3, 10))

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- posledni vrstva neuronu
    network:add(nn.Linear(10, 5))

    return network
end


function construct_three_layers_neural_network()
    local network = nn.Sequential()

    -- prvni vrstva neuronu
    network:add(nn.Linear(3, 10))

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- druha (skryta) vrstva neuronu
    network:add(nn.Linear(10, 15))

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- posledni vrstva neuronu
    network:add(nn.Linear(15, 5))

    return network
end


network = construct_simplest_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({1,2,3})))
print()

network = construct_two_layers_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({1,2,3})))
print()

network = construct_neural_network_with_nonlinear_functions()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({1,2,3})))
print()

network = construct_three_layers_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({1,2,3})))
print()

