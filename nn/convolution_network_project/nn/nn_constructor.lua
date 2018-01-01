--
--  (C) Copyright 2017, 2018  Pavel Tisnovsky
--
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the Eclipse Public License v1.0
--  which accompanies this distribution, and is available at
--  http://www.eclipse.org/legal/epl-v10.html
--
--  Contributors:
--      Pavel Tisnovsky
--

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


function construct_neural_network(width, height, input_planes, middle_planes,
                                  hidden_neurons, output_neurons,
                                  convolution_kernel_size, pooling_size, pooling_step)
    local network = nn.Sequential()

    local size_x = calculate_size_after_convolution(width, middle_planes, convolution_kernel_size)
    local size_y = calculate_size_after_convolution(height, middle_planes, convolution_kernel_size)

    print("Size x: " .. size_x)
    print("Size y: " .. size_y)

    -- prvni konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti:
    -- INPUT_PLANES x vyska x sirka
    --
    -- vysledkem je 3D tenzor o velikosti:
    -- MIDDLE_PLANES_1 x (vyska - CONVOLUTION_KERNEL_SIZE + 1) x (sirka - CONVOLUTION_KERNEL_SIZE + 1) 
    network:add(nn.SpatialConvolution(input_planes, middle_planes[1], convolution_kernel_size, convolution_kernel_size))

    -- nyni mame mezivysledky 64 x (vyska-5+1) x (sirka-5+1)

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(pooling_size, pooling_size, pooling_step, pooling_step))

    -- druha konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti MIDDLE_PLANES_1 x vyska x sirka
    network:add(nn.SpatialConvolution(middle_planes[1], middle_planes[2], convolution_kernel_size, convolution_kernel_size))

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- opetovne hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(pooling_size, pooling_size, pooling_step, pooling_step))

    -- zmena tvaru: z 3D tenzoru AxBxC na 1D tenzor s A*B*C elementy
    network:add(nn.View(middle_planes[2]*size_x*size_y))

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(middle_planes[2]*size_x*size_y, hidden_neurons))

    -- pridana nelinearni funkce
    network:add(nn.ReLU())

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(hidden_neurons, output_neurons))

    return network
end

