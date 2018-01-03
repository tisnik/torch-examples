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

require("utils/cifar_downloader")
require("utils/classification_classes")


-- globalni nastaveni
CLASSES = 10


-- parametry obrazku
WIDTH = 32
HEIGHT = 32


-- parametry neuronove site
INPUT_PLANES = 3

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

MAX_SIZE_OF_TRAINING_SET = 4000



network = construct_neural_network(WIDTH, HEIGHT, INPUT_PLANES, MIDDLE_PLANES,
                                   HIDDEN_NEURONS, OUTPUT_NEURONS,
                                   CONVOLUTION_KERNEL_SIZE, POOLING_SIZE, POOLING_STEP)

print("Struktura neuronove site")
print(network)

setup_cifar_dataset(original_data_address, zip_file_name)

input_training_set = torch.load('cifar10-train.t7')

--write_training_images_with_label(input_training_set, "cat")
--write_training_images_with_label(input_training_set, "truck")

print("Struktura vstupnich dat")
print(input_training_set.data:size())

training_data = prepare_training_data(input_training_set, MAX_SIZE_OF_TRAINING_SET)

train_neural_network(network, training_data, LEARNING_RATE, MAX_ITERATION)

validation_set = torch.load('cifar10-test.t7')

validate_neural_network(network, validation_set)
