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

WIDTH = 32
HEIGHT = 32


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


function construct_neural_network()
    local network = nn.Sequential()

    -- prvni konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti:
    -- INPUT_PLANES x vyska x sirka
    --
    -- vysledkem je 3D tenzor o velikosti:
    -- MIDDLE_PLANES_1 x (vyska - CONVOLUTION_KERNEL_SIZE + 1) x (sirka - CONVOLUTION_KERNEL_SIZE + 1) 
    network:add(nn.SpatialConvolution(INPUT_PLANES, MIDDLE_PLANES[1], CONVOLUTION_KERNEL_SIZE, CONVOLUTION_KERNEL_SIZE))

    -- nyni mame mezivysledky 64 x (32-5+1) x (32-5+1) = 64 x 28 x 28

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(POOLING_SIZE, POOLING_SIZE, POOLING_STEP, POOLING_STEP))

    -- nyni mame mezivysledky 64 x 28/2 x 28/2 = 64 x 14 x 14

    -- druha konvolucni vrstva ocekavajici na vstupu 3D tenzor
    -- o velikosti MIDDLE_PLANES_1 x vyska x sirka
    network:add(nn.SpatialConvolution(MIDDLE_PLANES[1], MIDDLE_PLANES[2], CONVOLUTION_KERNEL_SIZE, CONVOLUTION_KERNEL_SIZE))

    -- nyni mame mezivysledky 64 x (14-5+1) x (14-5+1) = 64 x 10 x 10

    -- nelinearni funkce
    network:add(nn.Tanh())

    -- opetovne hledani maxima v regionech o velikosti 2x2 pixely
    -- s krokem nastavenym na 2 pixely v horizontalnim i 2 pixely ve vertikalnim smeru
    network:add(nn.SpatialMaxPooling(POOLING_SIZE, POOLING_SIZE, POOLING_STEP, POOLING_STEP))

    -- nyni mame mezivysledky 64 x 10/2 x 10/2 = 64 x 5 x 5

    -- nyni mame mezivysledek o velikosti MIDDLE_PLANES_2 x 5 x 5
    -- zmena tvaru: z 3D tenzoru AxBxC na 1D tenzor s A*B*C elementy
    network:add(nn.View(MIDDLE_PLANES[2]*5*5))

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(MIDDLE_PLANES[2]*5*5, HIDDEN_NEURONS))

    -- pridana nelinearni funkce
    network:add(nn.ReLU())

    -- bezne vrstvy, jak je jiz zname
    network:add(nn.Linear(HIDDEN_NEURONS, OUTPUT_NEURONS))

    return network
end

network = construct_neural_network()
print(network)
