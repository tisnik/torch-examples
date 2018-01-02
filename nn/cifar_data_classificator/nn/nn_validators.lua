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


function plot_graph(filename, values)
    gnuplot.pngfigure(filename)
    gnuplot.imagesc(values, 'color')
    gnuplot.raw("set terminal pngcairo size 1280, 480")
    gnuplot.plotflush()
    gnuplot.close()
end


function validate_neural_network_using_noise_images(network, scale, noise, black_level, white_level, export_images)
    local errors = 0
    local count = 0
    for expected_digit = 0, 9 do
        local input = image2tensor(generate_noisy_image_for_validation(expected_digit, scale, noise,
                                                                       black_level, white_level, export_images))
        local output = network:forward(input)
        local result, weight = find_largest_item(output)
        if expected_digit ~= result then
            errors = errors + 1
        end
        print(expected_digit, result, expected_digit==result, weight)
        count = count + 1
    end
    print("---------------------")
    print("Errors: " .. errors)
    print("Error rate: " .. 100.0*errors/count .. "%")
end


function validate_neural_network_variable_noise(network, scale, digit,
                                                black_level, white_level, export_images)
    local max_noise = 1000
    local values = torch.Tensor(max_noise, DIGITS)

    for noise_variance = 1, max_noise do
        local input = image2tensor(generate_noisy_image_for_validation(digit, scale, noise_variance,
                                                                       black_level, white_level, export_images))
        local output = network:forward(input)
        values[noise_variance] = output
    end
    local output_graph_filename = string.format("digit%d_variable_noise.png", digit)
    plot_graph(output_graph_filename, values:t())
end


function validate_neural_network_using_jittered_images(network, scale, jitter_variance, black_level, white_level, export_images)
    local errors = 0
    local count = 0
    for expected_digit = 0, 9 do
        local input = image2tensor(generate_jittered_image_for_validation(expected_digit, scale, jitter_variance,
                                                                          black_level, white_level, export_images))
        local output = network:forward(input)
        local result, weight = find_largest_item(output)
        if expected_digit ~= result then
            errors = errors + 1
        end
        print(expected_digit, result, expected_digit==result, weight)
        count = count + 1
    end
    print("---------------------")
    print("Errors: " .. errors)
    print("Error rate: " .. 100.0*errors/count .. "%")
end


function validate_neural_network_variable_jitter(network, scale, digit,
                                                 black_level, white_level, export_images)
    local max_jitter = 20
    local values = torch.Tensor(max_jitter, DIGITS)

    for jitter_variance = 1, max_jitter do
        local input = image2tensor(generate_jittered_image_for_validation(digit, scale, jitter_variance,
                                                                          black_level, white_level, export_images))
        local output = network:forward(input)
        values[jitter_variance] = output
    end
    local output_graph_filename = string.format("digit%d_variable_jitter.png", digit)
    plot_graph(output_graph_filename, values:t())
end


