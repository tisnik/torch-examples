function string_to_wordlist(s)
    --words = s:split("[{}()%[%]'\":.*%s,#=_/%\\><;?-|+]")
    local words = s:gmatch("[%w&!@%%$~`$^]+")
    local result = {}
    for word in words do
        word = word:trim()
        -- ignorovat prazdna slova
        if word ~= "" then
            table.insert(result, word)
        end
    end
    return result
end


function load_words_from_file(filename)
    local source = load_source(filename)
    return string_to_wordlist(source)
end


function filter_words(vocabulary, min_word_count)
    local result = {}
    for word, count in pairs(vocabulary) do
        if count >= min_word_count then
            table.insert(result, word)
        end
    end
    return result
end


function make_vocabulary(filenames)
    local vocabulary = {}

    for _, filename in ipairs(filenames) do
        local words = load_words_from_file(filename)
        for _, word in ipairs(words) do
            if vocabulary[word] then
                vocabulary[word] = vocabulary[word] + 1
            else
                vocabulary[word] = 1
            end
        end
    end

    local words = filter_words(vocabulary, 5)
    table.sort(words)
    return words
end

