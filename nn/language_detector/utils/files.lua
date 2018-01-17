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

