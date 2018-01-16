--
--  (C) Copyright 2018  Pavel Tisnovsky
--
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the Eclipse Public License v1.0
--  which accompanies this distribution, and is available at
--  http://www.eclipse.org/legal/epl-v10.html
--
--  Contributors:
--      Pavel Tisnovsky
--

function find_largest_item(tensor)
    local index = -1
    local value = -math.huge
    for i = 0, 9 do
        if tensor[i+1] > value then
            index = i+1
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

function validate_neural_network(network, validation_set, mean, sd, max_size_of_validation_set)
    local errors = 0
    local count = 0

    -- celkovy pocet obrazku ve validacni mnozine
    local validation_set_size = validation_set.data:size(1)
    local validation_set_size = math.min(validation_set_size, max_size_of_validation_set)

    for i = 1, validation_set_size do
        -- tenzor s obrazkem ve formatu RGB
        local input = validation_set.data[i]
        local output = network:forward(input)
        local result, weight = find_largest_item(output)
        local expected = validation_set.label[i]
        if expected ~= result then
            errors = errors + 1
        end
        --print(classification_classes[expected], classification_classes[result], expected==result, weight)
        count = count + 1
    end
    local error_rate = 100.0*errors/count
    print("---------------------")
    print("Errors: " .. errors .. " out of " .. count .. " images")
    print("Error rate: " .. error_rate .. "%")
    print("Success rate: " .. 100.0-error_rate .. "%")
end

