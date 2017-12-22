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


function gaussian(mean, variance)
    return math.sqrt(-2 * variance * math.log(math.random())) *
           math.cos(2 * variance * math.pi * math.random()) + mean
end


function bound(value, min_value, max_value)
    return math.max(min_value, math.min(value, max_value))
end


function apply_noise(source_image, variance)
    local target_image = {}
    for y, row in ipairs(source_image) do
        target_image[y] = {}
        for x, pixel in ipairs(row) do
            local delta = math.floor(gaussian(0, variance))
            target_image[y][x] = bound(pixel + delta, 0, 255)
        end
    end
    return target_image
end


function apply_jitter(source_image, variance)
    local target_image = {}
    local max_x = #source_image[1]
    local max_y = #source_image

    for y = 1,max_y do
        target_image[y] = {}
        for x = 1,max_x do
            xs = x + math.floor(gaussian(0, variance))
            ys = y + math.floor(gaussian(0, variance))
            xs = bound(xs, 1, max_x)
            ys = bound(ys, 1, max_y)
            target_image[y][x] = source_image[ys][xs]
        end
    end
    return target_image
end


function translate(source_image, x_offset, y_offset)
    local target_image = {}
    local max_x = #source_image[1]
    local max_y = #source_image

    for y = 1,max_y do
        target_image[y] = {}
        for x = 1,max_x do
            xs = x - x_offset
            ys = y - y_offset
            xs = bound(xs, 1, max_x)
            ys = bound(ys, 1, max_y)
            target_image[y][x] = source_image[ys][xs]
        end
    end
    return target_image
end
