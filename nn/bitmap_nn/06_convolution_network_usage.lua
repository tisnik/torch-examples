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

require("nn")
require("image")

-- globalni nastaveni
DIGITS = 10


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

-- parametry pro uceni neuronove site
MAX_ITERATION = 200
LEARNING_RATE = 0.01


function calculate_size_after_convolution(input_size, middle_planes, convolution_kernel_size, pooling_size)
    local size = input_size
    for i=1,#middle_planes do
        -- velikost po projiti konvolucni vrstvou
        size = size - convolution_kernel_size + 1
        -- velikost po projiti pooling vrstvou
        size = size / pooling_size
    end
    return size
end


function construct_neural_network()
    local network = nn.Sequential()

    local size_x = calculate_size_after_convolution(WIDTH, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE, POOLING_SIZE)
    local size_y = calculate_size_after_convolution(HEIGHT, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE, POOLING_SIZE)

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


function train_neural_network(network, training_data, learning_rate, max_iteration)
    local criterion = nn.MSECriterion()
    local trainer = nn.StochasticGradient(network, criterion)
    trainer.learningRate = learning_rate
    trainer.maxIteration = max_iteration
    trainer:train(training_data)
end


function generate_expected_output(digit)
    local result = torch.zeros(DIGITS)
    result[digit+1] = 1
    return result
end


function prepare_training_data(training_files)
    local training_data_size = #training_files
    local training_data = {}
    function training_data:size() return training_data_size end

    for i, training_file in ipairs(training_files) do
        local input = image.load(training_file, 1, "byte"):double()
        local digit = tonumber(string.match(training_file, "%d+"))
        local output = generate_expected_output(digit)
        training_data[i] = {input, output}
    end

    return training_data
end


function read_filelist(mask)
    local command = "ls -1 " .. mask
    local handle = io.popen(command)
    local filelist = {}
    for line in handle:lines() do
        table.insert(filelist, line)
    end
    handle:close()
    return filelist
end


function find_largest_item(tensor)
    local index = -1
    local value = -math.huge
    for i = 0, 9 do
        if tensor[i+1] > value then
            index = i
            value = tensor[i+1]
        end
    end
    return index, value
end


function validate_neural_network(network, filelist)
    local errors = 0
    for i, filename in ipairs(filelist) do
        local input = image.load(filename, 1, "byte"):double()
        local expected_digit = tonumber(string.match(filename, "%d+"))
        local output = network:forward(input)
        local result, weight = find_largest_item(output)
        if expected_digit ~= result then
            errors = errors + 1
        end
        print(expected_digit, result, expected_digit==result, weight, filename)
    end
    print("---------------------")
    print("Errors: " .. errors)
    print("Error rate: " .. 100.0*errors/#filelist .. "%")
end


training_files = read_filelist("training*.pgm")

network = construct_neural_network()
print(network)

training_data = prepare_training_data(training_files)

train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)

validation_files = read_filelist("validation*.pgm")

validate_neural_network(network, validation_files)

