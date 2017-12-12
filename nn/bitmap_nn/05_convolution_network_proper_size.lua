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

require("nn")

WIDTH = 200
HEIGHT = 200


-- parametry neuronove site
INPUT_PLANES = 1

MIDDLE_PLANES = {64, 64}

HIDDEN_NEURONS = 100
OUTPUT_NEURONS = 10

-- parametry konvolucni vrstvy
CONVOLUTION_KERNEL_SIZE = 5

-- parametry pooling vrstvy
POOLING_SIZE = 2
POOLING_STEP = 2


function calculate_size_after_convolution(input_size, middle_planes, convolution_kernel_size)
    local size = input_size
    for i=1,#middle_planes do
        -- velikost po projiti konvolucni vrstvou
        size = size - convolution_kernel_size + 1
        -- velikost po projiti pooling vrstvou
        size = size / 2
    end
    return size
end


function construct_neural_network()
    local network = nn.Sequential()

    local size_x = calculate_size_after_convolution(WIDTH, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE)
    local size_y = calculate_size_after_convolution(HEIGHT, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE)

    print("Size x: " .. size_x)
    print("Size y: " .. size_y)

    -- prvni konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti:
    -- INPUT_PLANES x vyska x sirka
    --
    -- vysledkem je 3D tenzor o velikosti:
    -- MIDDLE_PLANES_1 x (vyska - CONVOLUTION_KERNEL_SIZE + 1) x (sirka - CONVOLUTION_KERNEL_SIZE + 1) 
    network:add(nn.SpatialConvolution(INPUT_PLANES, MIDDLE_PLANES[1], CONVOLUTION_KERNEL_SIZE, CONVOLUTION_KERNEL_SIZE))

    -- nyni mame mezivysledky 64 x (vyska-5+1) x (sirka-5+1)

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(POOLING_SIZE, POOLING_SIZE, POOLING_STEP, POOLING_STEP))

    -- druha konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti MIDDLE_PLANES_1 x vyska x sirka
    network:add(nn.SpatialConvolution(MIDDLE_PLANES[1], MIDDLE_PLANES[2], CONVOLUTION_KERNEL_SIZE, CONVOLUTION_KERNEL_SIZE))

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- opetovne hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(POOLING_SIZE, POOLING_SIZE, POOLING_STEP, POOLING_STEP))

    -- zmena tvaru: z 3D tenzoru AxBxC na 1D tenzor s A*B*C elementy
    network:add(nn.View(MIDDLE_PLANES[2]*size_x*size_y))

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(MIDDLE_PLANES[2]*size_x*size_y, HIDDEN_NEURONS))

    -- pridana nelinearni funkce
    network:add(nn.ReLU())

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(HIDDEN_NEURONS, OUTPUT_NEURONS))

    return network
end

network = construct_neural_network()
print(network)

