--
--  (C) Copyright 2017, 2018  Pavel Tisnovsky
--
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the Eclipse Public License v1.0
--  which accompanies this distribution, and is available at
--  http://www.eclipse.org/legal/epl-v10.html
--
--  Contributors:
--      Pavel Tisnovsky
--


function load_file(filename)
    local fin = io.open(filename, "r")

    -- check if it's possible to open the file for reading
    if not fin then
        return nil
    end

    -- try to read the whole file
    local content = fin:read("*all")

    -- check if file could be closed
    if not fin:close() then
        return nil
    end

    -- return content read from the input file
    return content
end


function remove_line_ends(s)
   return s:gsub("\n", " ")
end


function load_source(filename)
    local source = load_file(filename)
    return remove_line_ends(source)
end


function read_filelist(mask)
    local command = "ls -1 " .. mask
    local handle = io.popen(command)
    local filelist = {}
    for line in handle:lines() do
        table.insert(filelist, line)
    end
    handle:close()
    return filelist
end


function read_filelist_recursive(directory)
    local command = "find " .. directory .. " -type f"
    local handle = io.popen(command)
    local filelist = {}
    for line in handle:lines() do
        table.insert(filelist, line)
    end
    handle:close()
    return filelist
end

function write_table(filename, content)
    local fout = io.open(filename, "w")

    -- if file could be opened for writing into it
    if fout then
        for _, line in ipairs(content) do
            local result
            result = fout:write(line)

            -- in Lua 5.2 it is possible to check if write() was successful
            if not result then
                -- try to close the file
                fout:close()
                return nil
            end

            result = fout:write("\n")
            -- in Lua 5.2 it is possible to check if write() was successful
            if not result then
                -- try to close the file
                fout:close()
                return nil
            end
        end

        -- check if file could be closed
        if not fout:close() then
            return nil
        end

        -- open & write & close seems to be ok
        return true
    end
    -- file can't be opened
    -- -> return nil so this exception could be checked later
    return nil
end

function write_dictionary(filename, content)
    local fout = io.open(filename, "w")

    -- if file could be opened for writing into it
    if fout then
        for key, val in pairs(content) do
            local result
            result = fout:write(tostring(key) .. "\t" .. tostring(val))

            -- in Lua 5.2 it is possible to check if write() was successful
            if not result then
                -- try to close the file
                fout:close()
                return nil
            end

            result = fout:write("\n")
            -- in Lua 5.2 it is possible to check if write() was successful
            if not result then
                -- try to close the file
                fout:close()
                return nil
            end
        end

        -- check if file could be closed
        if not fout:close() then
            return nil
        end

        -- open & write & close seems to be ok
        return true
    end
    -- file can't be opened
    -- -> return nil so this exception could be checked later
    return nil
end

