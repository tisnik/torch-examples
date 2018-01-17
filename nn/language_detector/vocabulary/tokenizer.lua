words = {"zoom", "a", "zoom", "zero", "word", "zu", "zero", "zu", "zero", "aaaaaaaaaaaa"}

-- https://github.com/keras-team/keras/blob/master/keras/preprocessing/text.py#L119

function make_word_to_index_mapping(words)
    local uniq_words = {}
    local word_counts = {}
    for _, word in ipairs(words) do
        if word_counts[word] then
            word_counts[word] = word_counts[word] + 1
        else
            word_counts[word] = 1
            table.insert(uniq_words, word)
        end
    end

    -- tabulka obsahujici dvojice [slovo+frekvence] setridene sestupne podle frekvence
    local wcounts = {}
    for _, word in ipairs(uniq_words) do
        table.insert(wcounts, {word, word_counts[word]})
    end
    table.sort(wcounts, function(x,y) return x[2] > y[2] end)

    -- seznam slov setrideny sestupne podle frekvenci
    local sorted_voc = {}
    for _, wc in ipairs(wcounts) do
        table.insert(sorted_voc, wc[1])
    end

    -- slovnik slovo -> index
    local word_index = {}
    for i, w in ipairs(sorted_voc) do
        word_index[w] = i
    end
    return word_index
end

-- pouziti:
--[[
word_index = make_word_to_index_mapping(words)

for word, index in pairs(word_index) do
    print(word, index)
end
--]]
