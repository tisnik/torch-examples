function write_training_image(training_set, n)
    -- kontrola, jestli obrazek s danym indexem "n" skutecne existuje
    local size=training_set.data:size(1)
    if n < 1 or n > size then
        print("Training image " .. n .. " does not exist!")
        return
    end

    -- index popisky obrazku
    local label_index = training_set.label[n]

    -- vlastni (textovy) popisek obrazku
    local label = classification_classes[label_index]

    -- ulozeni obrazku
    store_image(training_set, n, label)
end


function store_image(training_set, n, label)
    -- konstrukce jmena souboru
    local filename = string.format("training_image_%05d_%s.png", n, label)

    -- zapis dat ve formatu PNG
    local img = training_set.data[n]
    image.save(filename, img)
end


function write_training_images_with_label(training_set, label)
    -- celkovy pocet obrazku v trenovaci mnozine
    local size=training_set.data:size(1)

    -- index tridy obrazku
    local label_index = get_label_index(label)

    -- projit vsemi obrazky v sade
    for i = 1, size do
        -- filtrace obrazku
        if training_set.label[i] == label_index then
            store_image(training_set, i, label)
        end
    end
end

