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
require("image")
require("gnuplot")

require("image_lib/image_renderer")
require("image_lib/image_writer")
require("image_lib/image_filters")
require("image_lib/image_generator")

require("nn/nn_constructor")
require("nn/nn_trainer")
require("nn/nn_validators")


-- globalni nastaveni
DIGITS = 10


-- parametry obrazku
WIDTH = 32
HEIGHT = 32
BLACK_LEVEL = 64
WHITE_LEVEL = 192


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

-- dalsi parametry
EXPORT_IMAGES = true



network, c1, c2 = construct_neural_network(WIDTH, HEIGHT, INPUT_PLANES, MIDDLE_PLANES,
                                           HIDDEN_NEURONS, OUTPUT_NEURONS,
                                           CONVOLUTION_KERNEL_SIZE, POOLING_SIZE, POOLING_STEP)

print("Struktura neuronove site")
print(network)

NOISE_VARIANCES = {0, 10, 20, 50}
REPEAT_COUNT = 3
SCALE = 4

training_data = prepare_training_data(SCALE, NOISE_VARIANCES, REPEAT_COUNT,
                                      BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)

train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)

print(c1.weight)
print(c2.weight)

print(c1.weight:size())
print(c2.weight:size())

function serialize(data, filename)
    local fout = torch.DiskFile(filename, "w"):ascii()
    fout:writeObject(data)
    fout:close()
end

serialize(c1.weight, "c1.asc")
serialize(c2.weight, "c2.asc")

validate_neural_network_using_noise_images(network, SCALE, 100, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_noise_images(network, SCALE, 1000, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_noise_images(network, SCALE, 2500, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_noise_images(network, SCALE, 5000, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)


for digit = 0, 9 do
    print("splot for digit " .. digit)
    validate_neural_network_variable_noise(network, SCALE, digit, BLACK_LEVEL, WHITE_LEVEL)
end

validate_neural_network_using_jittered_images(network, SCALE, 1, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_jittered_images(network, SCALE, 2, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_jittered_images(network, SCALE, 5, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_jittered_images(network, SCALE, 10, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
validate_neural_network_using_jittered_images(network, SCALE, 20, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)

for digit = 0, 9 do
    print("splot for digit " .. digit)
    validate_neural_network_variable_jitter(network, SCALE, digit, BLACK_LEVEL, WHITE_LEVEL, EXPORT_IMAGES)
end

