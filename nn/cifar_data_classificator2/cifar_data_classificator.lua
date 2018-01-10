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

require("nn")
require("image")
require("gnuplot")

require("image_lib/image_writer")

require("nn/nn_constructor")
require("nn/nn_trainer")
require("nn/nn_validators")
require("nn/nn_serialization")

require("utils/cifar_downloader")
require("utils/classification_classes")
require("utils/data_normalizer")


-- globalni nastaveni
CLASSES = 10
USE_SERIALIZED_NN = False


-- parametry obrazku
CHANNELS = 3
WIDTH = 32
HEIGHT = 32


-- parametry neuronove site
INPUT_PLANES = 3

MIDDLE_PLANES = {64, 64}

HIDDEN_NEURONS = 100
OUTPUT_NEURONS = 10

ADDITIONAL_LAYERS = 4

-- parametry konvolucni vrstvy
CONVOLUTION_KERNEL_SIZE = 5

-- parametry pooling vrstvy
POOLING_SIZE = 2
POOLING_STEP = 2

-- parametry pro uceni neuronove site
MAX_ITERATION = tonumber(arg[1])
LEARNING_RATE = 0.005

MAX_SIZE_OF_TRAINING_SET = tonumber(arg[2])
MAX_SIZE_OF_VALIDATION_SET = 10000

setup_cifar_dataset(original_data_address, zip_file_name)

input_training_set = torch.load('cifar10-train.t7')
input_training_set.data = input_training_set.data:double()

print("Prumer a standardni odchylka hodnot pixelu pred normalizaci")
-- spocitat prumer a smerodatnou odchylku pro vsechny kanaly
mean, sd = calculate_mean_and_sd(input_training_set, CHANNELS)
print_mean_and_sd(mean, sd, CHANNELS)
print()

-- normalizace trenovacich dat
normalize_data(input_training_set, mean, sd, CHANNELS)

print("Prumer a standardni odchylka hodnot pixelu po normalizaci")
-- nyni by mel byt prumer prakticky nulovy a odchylka rovna jedne
new_mean, new_sd = calculate_mean_and_sd(input_training_set, CHANNELS)
print_mean_and_sd(new_mean, new_sd, CHANNELS)
print()

--write_training_images_with_label(input_training_set, "cat")
--write_training_images_with_label(input_training_set, "truck")

print("Struktura vstupnich dat")
print(input_training_set.data:size())

training_data = prepare_training_data(input_training_set, MAX_SIZE_OF_TRAINING_SET)


if not USE_SERIALIZED_NN then
    network = construct_neural_network(WIDTH, HEIGHT, INPUT_PLANES, MIDDLE_PLANES,
                                       HIDDEN_NEURONS, OUTPUT_NEURONS,
                                       CONVOLUTION_KERNEL_SIZE, POOLING_SIZE, POOLING_STEP,
                                       ADDITIONAL_LAYERS)

    print("Struktura neuronove site")
    print(network)
    train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)

    serialize_nn(network)
else
    network = deserialize_nn()
end


validation_set = torch.load('cifar10-test.t7')
--validation_set = torch.load('cifar10-train.t7')

validation_set.data = validation_set.data:double()
-- normalizace validacnich dat
normalize_data(validation_set, mean, sd, CHANNELS)

validate_neural_network(network, validation_set, mean, sd, MAX_SIZE_OF_VALIDATION_SET)
