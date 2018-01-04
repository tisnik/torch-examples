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
require("gnuplot")

-- parametry neuronove site
INPUT_NEURONS = 64
HIDDEN_NEURONS = 100
OUTPUT_NEURONS = 10

-- parametry pro uceni neuronove site
MAX_ITERATION = 200
LEARNING_RATE = 0.01

NOISE = {0, 8, 16}--, 32}
REPEAT_COUNT = 5

DIGITS = 10

digits = {
    {0x00, 0x3C, 0x66, 0x76, 0x6E, 0x66, 0x3C, 0x00 },
    {0x00, 0x18, 0x1C, 0x18, 0x18, 0x18, 0x7E, 0x00 },
    {0x00, 0x3C, 0x66, 0x30, 0x18, 0x0C, 0x7E, 0x00 },
    {0x00, 0x7E, 0x30, 0x18, 0x30, 0x66, 0x3C, 0x00 },
    {0x00, 0x30, 0x38, 0x3C, 0x36, 0x7E, 0x30, 0x00 },
    {0x00, 0x7E, 0x06, 0x3E, 0x60, 0x66, 0x3C, 0x00 },
    {0x00, 0x3C, 0x06, 0x3E, 0x66, 0x66, 0x3C, 0x00 },
    {0x00, 0x7E, 0x60, 0x30, 0x18, 0x0C, 0x0C, 0x00 },
    {0x00, 0x3C, 0x66, 0x3C, 0x66, 0x66, 0x3C, 0x00 },
    {0x00, 0x3C, 0x66, 0x7C, 0x60, 0x30, 0x1C, 0x00 },
}

function generate_image_data(digit, noise_amount)
    local codes = digits[digit+1]

    local index = 1
    local result = torch.Tensor(8*8)

    for _, code in ipairs(codes) do
        for i = 1,8 do
            local bit = code % 2
            local value = 192*bit + math.random(0,noise_amount)
            result[index] = value
            index = index + 1
            code = (code - bit)/2
        end
    end
    return result
end


function generate_expected_output(digit)
    local result = torch.zeros(DIGITS)
    result[digit+1] = 1
    return result
end


function prepare_training_data()
    local training_data_size = #NOISE * REPEAT_COUNT * DIGITS
    local training_data = {}
    function training_data:size() return training_data_size end

    local index = 1

    for _, noise_amount in ipairs(NOISE) do
        for digit = 0, 9 do
            for i = 1, REPEAT_COUNT do
                local input = generate_image_data(digit, noise_amount)
                local output = generate_expected_output(digit)
                training_data[index] = {input, output}
                index = index + 1
            end
        end
    end
    return training_data
end


function construct_neural_network(input_neurons, hidden_neurons, output_neurons)
    local network = nn.Sequential()

    network:add(nn.Linear(input_neurons, hidden_neurons))
    network:add(nn.Tanh())
    network:add(nn.Linear(hidden_neurons, output_neurons))
    -- pridana nelinearni funkce
    network:add(nn.Tanh())
    
    return network
end


function train_neural_network(network, training_data, learning_rate, max_iteration)
    local criterion = nn.MSECriterion()
    local trainer = nn.StochasticGradient(network, criterion)
    trainer.learningRate = learning_rate
    trainer.maxIteration = max_iteration
    trainer:train(training_data)
end


function plot_graph(filename, values)
    gnuplot.pngfigure(filename)
    gnuplot.imagesc(values, 'color')

    gnuplot.plotflush()
    gnuplot.close()
end


function validate_neural_network(network, digit, noise_amount)
    local data_size = 100
    local values = torch.Tensor(data_size, DIGITS)

    for i = 1, data_size do
        local input = generate_image_data(digit, noise_amount)
        local output = network:forward(input)
        values[i] = output
        --print(output)
    end
    local filename = string.format("digit%d_noise%d.png", digit, noise_amount)
    plot_graph(filename, values:t())
end


function validate_neural_network_variable_noise(network, digit)
    local data_size = 64
    local values = torch.Tensor(data_size, DIGITS)

    for noise_amount = 0, data_size-1 do
        local input = generate_image_data(digit, noise_amount)
        local output = network:forward(input)
        values[noise_amount+1] = output
    end
    local filename = string.format("digit%d_variable_noise.png", digit)
    plot_graph(filename, values:t())
end


network = construct_neural_network(INPUT_NEURONS, HIDDEN_NEURONS, OUTPUT_NEURONS)
print(network)

training_data = prepare_training_data()

train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)

for digit = 0, 9 do
    validate_neural_network_variable_noise(network, digit)
end

for noise = 0, 60, 15 do
    validate_neural_network(network, 1, noise)
    validate_neural_network(network, 3, noise)
    validate_neural_network(network, 8, noise)
end

