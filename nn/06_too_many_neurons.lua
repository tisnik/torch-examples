require("nn")

TRAINING_DATA_SIZE = 500

INPUT_NEURONS = 2
HIDDEN_NEURONS = 200
OUTPUT_NEURONS = 1

MAX_ITERATION = 200
LEARNING_RATE = 0.01


function prepare_training_data(training_data_size)
    local training_data = {}
    function training_data:size() return training_data_size end
    for i = 1,training_data_size do
        local input = torch.randn(2)
        local output = torch.Tensor(1)
        output[1] = input[1] + input[2]
        training_data[i] = {input, output}
    end
    return training_data
end


function construct_neural_network(input_neurons, hidden_neurons, output_neurons)
    local network = nn.Sequential()

    network:add(nn.Linear(input_neurons, hidden_neurons))
    network:add(nn.ReLU())
    --network:add(nn.Tanh())
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
        d1, d2 = d[1], d[2]
        input = torch.Tensor({d1, d2})
        prediction = network:forward(input)[1]
        correct = d1 + d2
        err = math.abs(100.0 * (prediction-correct)/correct)
        msg = string.format("%2d  %+6.3f  %+6.3f  %+6.3f  %+6.3f  %4.0f%%", i, d1, d2, correct, prediction, err)
        print(msg)
    end
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

