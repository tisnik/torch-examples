max_iterations="10 20 50 100 200 500 1000 2000 5000"
training_set_sizes="10 20 50 100 200 500 1000 2000 5000 10000"

for max_iteration in $max_iterations
do
    for training_set_size in $training_set_sizes
    do
        th cifar_data_classificator.lua $max_iteration $training_set_size > "${max_iteration}_${training_set_size}.txt"
    done
done
