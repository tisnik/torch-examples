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

TRAINING_DATA_SIZE = 500

INPUT_NEURONS = 2
HIDDEN_NEURONS = 200
OUTPUT_NEURONS = 1

MAX_ITERATION = 500
LEARNING_RATE = 0.01


function prepare_training_data(training_data_size)
    local training_data = {}
    function training_data:size() return training_data_size end
    for i = 1,training_data_size do
        local input = 2*torch.randn(2)
        local output = torch.Tensor(1)
        output[1] = input[1] + input[2]
        training_data[i] = {input, output}
    end
    return training_data
end


function construct_neural_network(input_neurons, hidden_neurons, output_neurons)
    local network = nn.Sequential()

    network:add(nn.Linear(input_neurons, hidden_neurons))
    --network:add(nn.ReLU())
    network:add(nn.Tanh())
    network:add(nn.Linear(hidden_neurons, output_neurons))
    
    return network
end


function train_neural_network(network, training_data, learning_rate, max_iteration)
    local criterion = nn.MSECriterion()
    local trainer = nn.StochasticGradient(network, criterion)
    trainer.learningRate = learning_rate
    trainer.maxIteration = max_iteration
    trainer:train(training_data)
end


function validate_neural_network(network, validation_data)
    for i,d in ipairs(validation_data) do
        local d1, d2 = d[1], d[2]
        local input = torch.Tensor({d1, d2})
        local prediction = network:forward(input)[1]
        local correct = d1 + d2
        local err = math.abs(100.0 * (prediction-correct)/correct)
        local msg = string.format("%2d  %+6.3f  %+6.3f  %+6.3f  %+6.3f  %4.0f%%", i, d1, d2, correct, prediction, err)
        print(msg)
    end
end


function plot_graph(filename, x, y1, y2)
    gnuplot.pngfigure(filename)
    gnuplot.title("Adder NN")
    gnuplot.xlabel("x")
    gnuplot.ylabel("x+y")
    gnuplot.movelegend("left", "top")

    gnuplot.plot({"correct", x, y1},
                 {"predict", x, y2})

    gnuplot.plotflush()
    gnuplot.close()
end


function prepare_graph(filename, from, to, items, d1)
    local x = torch.linspace(from, to, items)
    local size = x:size(1)

    local y1 = torch.Tensor(size)
    local y2 = torch.Tensor(size)

    for i = 1, size do
        local d2 = x[i]
        -- presny vysledek
        y1[i] = d1 + d2

        -- vstup do neuronove site
        local input = torch.Tensor({d1, d2})
        -- vysledek odhadnuty neuronovou siti
        local prediction = network:forward(input)[1]
        y2[i] = prediction
    end
    plot_graph(filename, x, y1, y2)
end


network = construct_neural_network(INPUT_NEURONS, HIDDEN_NEURONS, OUTPUT_NEURONS)
training_data = prepare_training_data(TRAINING_DATA_SIZE)
train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)
print(network)


x=torch.Tensor({0.5, -0.5})
prediction = network:forward(x)
print(prediction)

validation_data = {
    { 1.0,  1,0},
    { 0.5,  0.5},
    { 0.2,  0.2},
    -------------
    {-1.0,  1.1},
    {-0.5,  0.6},
    {-0.2,  0.3},
    -------------
    { 1.0, -1.1},
    { 0.5, -0.6},
    { 0.2, -0.3},
    -------------
    {-1.0, -1,0},
    {-0.5, -0.5},
    {-0.2, -0.2},
}

validate_neural_network(network, validation_data)

prepare_graph("adder_b1.png", -2, 2, 21, 0.5)
prepare_graph("adder_b2.png", -10, 10, 21, 0.5)
prepare_graph("adder_b3.png", -2, 2, 21, 2.0)
prepare_graph("adder_b4.png", -2, 2, 21, 5.0)
