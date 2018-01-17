function string:split(separator)
    -- if separator is not given, simply return a table containing
    -- just one item - the string itself
    if not separator then
        return {self}
    end

    -- table which would contain result - parts of original string
    local parts = {}
    local pattern = string.format("([^%s]+)", separator)
    print(pattern)
    -- split the string using anonymous function called for each group
    self:gsub(pattern, function(c) parts[#parts+1] = c end)
    return parts
end


function string.trim(str)
    -- make sure we don't get 'NPE'
    if not str then
        return nil
    end
    if str:find("^%s*$") then -- string contains only whitespace(s)
        return ""
    else
        return str:match("^%s*(.*%S)")
    end
end

