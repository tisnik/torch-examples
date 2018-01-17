require("utils/files")
require("utils/strings")
require("vocabulary/maker")
require("vocabulary/tokenizer")

TRAIN_DATA_DIRECTORY = "train_data/linux-0.01"

local train_files = read_filelist_recursive(TRAIN_DATA_DIRECTORY)

local vocabulary = make_vocabulary(train_files)

write_table("vocabulary.txt", vocabulary)

write_dictionary("tokens.txt", tokens)

