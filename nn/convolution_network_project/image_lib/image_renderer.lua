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


function get_codes_for_digit(digit)
    if digit < 0 or digit > 9 then
        return nil
    end
    return digits[digit+1]
end


function setpixel(image, x, y, bit, white_level, black_level)
    if bit==1 then
        image[y][x] = white_level
    else
        image[y][x] = black_level
    end
end


function generate_image(digit, scale, black_level, white_level)
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
                    setpixel(image, x_offset, y_offset, bit, white_level, black_level)
                    x_offset = x_offset + 1
                end
            end
            y_offset = y_offset + 1
        end
    end
    return image
end

