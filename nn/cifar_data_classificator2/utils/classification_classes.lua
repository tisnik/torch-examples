classification_classes = {
    'airplane',
    'automobile',
    'bird',
    'cat',
    'deer',
    'dog',
    'frog',
    'horse',
    'ship',
    'truck'
}


function get_label_index(label)
    for i, lbl in ipairs(classification_classes) do
        if lbl == label then
            return i
        end
    end
    return nil
end

