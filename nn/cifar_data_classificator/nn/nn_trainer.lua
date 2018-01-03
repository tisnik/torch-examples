function train_neural_network(network, training_data, learning_rate, max_iteration)
    local criterion = nn.MSECriterion()
    local trainer = nn.StochasticGradient(network, criterion)
    trainer.learningRate = learning_rate
    trainer.maxIteration = max_iteration
    trainer:train(training_data)
end


function generate_expected_output(class)
    local result = torch.zeros(CLASSES)
    result[class] = 1
    return result
end


function prepare_training_data(training_set, max_size_of_training_set)
    -- celkovy pocet obrazku v trenovaci mnozine
    local input_training_set_size = training_set.data:size(1)
    local training_data_size = math.min(input_training_set_size, max_size_of_training_set)

    -- priprava tenzoru s trenovacimi daty
    local training_data = {}
    function training_data:size() return training_data_size end

    -- projit vsemi obrazky v sade
    for i = 1, training_data_size do
        -- tenzor s obrazkem ve formatu RGB
        local input = training_set.data[i]:double()
        local label_index = training_set.label[i]
        -- tenzor s desetiprvkovym vektorem obsahujicim jen hodnoty 0 a 1
        local output = generate_expected_output(label_index)
        training_data[i] = {input, output}
    end

    return training_data
end

