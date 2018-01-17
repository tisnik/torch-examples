require("nn")


function construct_complex_parallel_neural_network()
    -- tenzor se rozdeli podle prvni dimenze
    -- vysledky se spoji taktez podle prvni dimenze
    local network = nn.Parallel(1,1)

    -- jedina vrstva neuronu, provadi se paralelne s podsiti
    network:add(nn.Linear(3, 1))

    -- podsit
        local subnetwork = nn.Sequential()
        -- klasicka vrstva neuronu
        subnetwork:add(nn.Linear(3, 2))
        -- potrebujeme ziskat tenzor o rozmerech 2x1 prvek
        -- z jednodimenzionalniho tenzoru se dvema prvky
        subnetwork:add(nn.Reshape(2, 1))

    network:add(subnetwork)

    return network
end


function construct_more_complex_parallel_neural_network()
    -- tenzor se rozdeli podle prvni dimenze
    -- vysledky se spoji taktez podle prvni dimenze
    local network = nn.Parallel(1,1)

    -- na vstupu potrebujeme zpracovat ctyrikrat tri vstupy
    for i=1,4 do
        -- podsit
        local subnetwork = nn.Sequential()
        -- klasicka vrstva neuronu
        subnetwork:add(nn.Linear(3, 10))
        -- nelinearni funkce
        subnetwork:add(nn.Tanh())
        -- dalsi vrstva neuronu
        subnetwork:add(nn.Linear(10, 2))
        -- potrebujeme ziskat tenzor o rozmerech 2x1 prvek
        -- z jednodimenzionalniho tenzoru se dvema prvky
        subnetwork:add(nn.Reshape(2, 1))
        network:add(subnetwork)
    end

    return network
end


function construct_even_more_complex_parallel_neural_network()
    local network = nn.Sequential()
        -- tenzor se rozdeli podle prvni dimenze
        -- vysledky se spoji taktez podle prvni dimenze
        local subnetwork = nn.Parallel(1,1)

        -- na vstupu potrebujeme zpracovat ctyrikrat tri vstupy
        for i=1,4 do
            -- podsit
            local subsubnetwork = nn.Sequential()
            -- klasicka vrstva neuronu
            subsubnetwork:add(nn.Linear(3, 10))
            -- nelinearni funkce
            subsubnetwork:add(nn.Tanh())
            -- dalsi vrstva neuronu
            subsubnetwork:add(nn.Linear(10, 2))
            -- potrebujeme ziskat tenzor o rozmerech 2x1 prvek
            -- z jednodimenzionalniho tenzoru se dvema prvky
            subsubnetwork:add(nn.Reshape(2, 1))
            subnetwork:add(subsubnetwork)
        end

    -- pridame paralelni sit do sekvence vrstev
    network:add(subnetwork)

    -- zmena tvaru tenzoru (vektor s osmi prvky)
    network:add(nn.View(8))

    -- klasicka vrstva neuronu
    network:add(nn.Linear(8, 10))

    -- nelinearni funkce
    network:add(nn.Tanh())
    -- klasicka vrstva neuronu
    network:add(nn.Linear(10, 2))

    return network
end


network = construct_complex_parallel_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({{1,2,3}, {4,5,6}})))
print()

network = construct_more_complex_parallel_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({{1,2,3}, {4,5,6}, {7,8,9}, {9,-1,-1}})))
print()

network = construct_even_more_complex_parallel_neural_network()
print(network)
-- kontrola site se musi provest az v runtime
print(network:forward(torch.Tensor({{1,2,3}, {4,5,6}, {7,8,9}, {9,-1,-1}})))
print()

