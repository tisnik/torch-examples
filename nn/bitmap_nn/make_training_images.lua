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

NOISE = {0, 8, 16, 32, 63}
REPEAT_COUNT = 5

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

function generate_image(filename, digit, noise_amount)
    if digit < 0 or digit > 9 then
        return
    end
    local codes = digits[digit+1]

    local fout = io.open(filename, "w")
    if not fout then
        return
    end

    -- hlavicka
    fout:write("P2\n8 8\n255\n")

    for _, code in ipairs(codes) do
        local s = ""
        for i = 1,8 do
            local bit = code % 2
            fout:write(192*bit + math.random(0,noise_amount))
            fout:write(" ")
            s = s .. bit
            code = (code - bit)/2
        end
        print(s)
    end
    print()
    fout:close()
end

for _, noise in ipairs(NOISE) do
    for digit = 0, 9 do
        for i = 1, REPEAT_COUNT do
            local filename = string.format("%d_%d_%d.pgm", digit, noise, i)
            generate_image(filename, digit, noise)
        end
    end
end

