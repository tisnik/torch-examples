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


function prepare_training_data(scale, noise_variances, repeat_count,
                               black_level, white_level, export_images)
    local training_images = generate_training_images(scale, noise_variances, repeat_count,
                                                     black_level, white_level, export_images)
    local training_data_size = #training_images
    local training_data = {}
    function training_data:size() return training_data_size end

    for i, training_image in ipairs(training_images) do
        local input = image2tensor(training_image.data)
        local digit = training_image.digit
        local output = generate_expected_output(digit)
        training_data[i] = {input, output}
    end

    return training_data
end

