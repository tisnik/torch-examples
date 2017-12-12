NOISE_VARIANCE = {0, 10, 20, 50, 100, 200}
JITTER_VARIANCE = {0, 1, 2}
REPEAT_COUNT = 3

SCALE = 4

digits = {
    {0x00, 0x3C, 0x66, 0x76, 0x6E, 0x66, 0x3C, 0x00 },
    {0x00, 0x18, 0x1C, 0x18, 0x18, 0x18, 0x7E, 0x00 },
    {0x00, 0x3C, 0x66, 0x30, 0x18, 0x0C, 0x7E, 0x00 },
    {0x00, 0x7E, 0x30, 0x18, 0x30, 0x66, 0x3C, 0x00 },
    {0x00, 0x30, 0x38, 0x3C, 0x36, 0x7E, 0x30, 0x00 },
    {0x00, 0x7E, 0x06, 0x3E, 0x60, 0x66, 0x3C, 0x00 },
    {0x00, 0x3C, 0x06, 0x3E, 0x66, 0x66, 0x3C, 0x00 },
    {0x00, 0x7E, 0x60, 0x30, 0x18, 0x0C, 0x0C, 0x00 },
    {0x00, 0x3C, 0x66, 0x3C, 0x66, 0x66, 0x3C, 0x00 },
    {0x00, 0x3C, 0x66, 0x7C, 0x60, 0x30, 0x1C, 0x00 },
}

function write_image(filename, image)
    local fout = io.open(filename, "w")
    if not fout then
        return
    end

    -- rozliseni obrazku
    local x_resolution = #image[1]
    local y_resolution = #image

    -- zapis hlavicky
    fout:write("P2\n")
    fout:write(x_resolution)
    fout:write(" ")
    fout:write(y_resolution)
    fout:write("\n255\n")

    -- zapis jednotlivych pixelu
    for j, row in ipairs(image) do
        for i, pixel in ipairs(row) do
            -- logika pro oddeleni hodnot
            if i ~= 1 then
                fout:write(" ")
            end
            fout:write(pixel)
        end
        -- odradkovani neni nutne
        fout:write("\n")
    end

    fout:close()
end


function get_codes_for_digit(digit)
    if digit < 0 or digit > 9 then
        return nil
    end
    return digits[digit+1]
end


function setpixel(image, x, y, bit, white_value, black_value)
    if bit==1 then
        image[y][x] = white_value
    else
        image[y][x] = black_value
    end
end


function generate_image(digit, scale, black_value, white_value)
    local codes = get_codes_for_digit(digit)
    local image = {}
    local y_offset = 1
    for _, code in ipairs(codes) do
        for y = 1,scale do
            -- vytvorit dalsi obrazovy radek
            image[y_offset] = {}
            local x_offset = 1
            local byte = code
            -- vypocet barev jednotlivych pixelu v obrazku
            for _ = 1,8 do
                -- zjistit hodnotu n-teho bitu + posun bajtu s maskou znaku
                local bit = byte % 2
                byte = (byte - bit)/2
                for x = 1,scale do
                    -- obarveni konkretniho pixelu
                    setpixel(image, x_offset, y_offset, bit, white_value, black_value)
                    x_offset = x_offset + 1
                end
            end
            y_offset = y_offset + 1
        end
    end
    return image
end


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


function generate_training_images()
    for _, variance in ipairs(NOISE_VARIANCE) do
        for digit = 0, 9 do
            for i = 1, REPEAT_COUNT do
                local image = generate_image(digit, SCALE, 64, 192)
                image = apply_noise(image, variance)
                local filename = string.format("training_%d_%d_%d.pgm", digit, variance, i)
                write_image(filename, image)
            end
        end
    end
end

NOISE_VARIANCE = {20, 50, 100, 200}
JITTER_VARIANCE = {0, 1, 2}
REPEAT_COUNT = 2

function generate_images_for_validation()
    for _, noise_variance in ipairs(NOISE_VARIANCE) do
        for _, jitter_variance in ipairs(JITTER_VARIANCE) do
            for digit = 0, 9 do
                for i = 1, REPEAT_COUNT do
                    local image = generate_image(digit, SCALE, 64, 192)
                    image = apply_noise(image, noise_variance)
                    image = apply_jitter(image, jitter_variance)
                    local filename = string.format("validation_%d_%d_%d_%d.pgm", digit, noise_variance, jitter_variance, i)
                    write_image(filename, image)
                end
            end
        end
    end
end

generate_training_images()
generate_images_for_validation()
