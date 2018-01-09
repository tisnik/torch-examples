function calculate_mean_and_sd(training_set, channels)
    -- prumer
    local mean = {}

    -- smerodatna odchylka
    local sd = {}

    for channel = 1,channels do
        mean[channel] = training_set.data[{ {}, {channel}, {}, {}  }]:mean()
        sd[channel] = training_set.data[{ {}, {channel}, {}, {}  }]:std()
    end

    return mean, sd
end

function print_mean_and_sd(mean, sd, channels)
    for channel = 1,channels do
        print("Kanal: " .. channel)
        print("    prumer:   " .. mean[channel])
        print("    odchylka: " .. sd[channel])
    end
end

function normalize_data(training_set, mean, sd, channels)
    for channel = 1,channels do
        training_set.data[{ {}, {channel}, {}, {}  }]:add(-mean[channel])
        training_set.data[{ {}, {channel}, {}, {}  }]:div(sd[channel])
    end
end
