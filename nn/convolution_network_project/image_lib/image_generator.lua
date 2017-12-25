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


function generate_training_images(scale, noise_variances, repeat_count, black_level, white_level, export_images)
    local training_images = {}
    for _, noise_variance in ipairs(noise_variances) do
        for digit = 0, 9 do
            for i = 1, repeat_count do
                local training_image = generate_image(digit, scale, black_level, white_level)
                training_image = apply_noise(training_image, noise_variance)
                table.insert(training_images, {digit=digit,
                                               data=training_image})
                if export_images then
                    local filename = string.format("training_%d_%d_%d.pgm", digit, noise_variance, i)
                    write_image(filename, training_image)
                end
            end
        end
    end
    return training_images
end


function noisy_image_filename(digit, noise_variance)
    return string.format("validation_%d_noise_%d.pgm", digit, noise_variance)
end


function generate_noisy_image_for_validation(digit, scale, noise_variance, black_level, white_level, export_image)
    local validation_image = generate_image(digit, scale, black_level, white_level)
    validation_image = apply_noise(validation_image, noise_variance)
    if export_image then
        local filename = noisy_image_filename(digit, noise_variance)
        write_image(filename, validation_image)
    end
    return validation_image
end


function jitter_image_filename(digit, jitter_variance)
    return string.format("validation_%d_jitter_%d.pgm", digit, jitter_variance)
end


function generate_jittered_image_for_validation(digit, scale, jitter_variance, black_level, white_level, export_image)
    local validation_image = generate_image(digit, scale, black_level, white_level)
    validation_image = apply_jitter(validation_image, jitter_variance)
    if export_image then
        local filename = jitter_image_filename(digit, jitter_variance)
        write_image(filename, validation_image)
    end
    return validation_image
end


function image2tensor(image)
    -- image is 2d table: height x width
    -- but we need 3d table: 1 x height x width
    local table3d = {image}
    return torch.Tensor(table3d):double()
end

