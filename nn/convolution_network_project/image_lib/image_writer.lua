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
