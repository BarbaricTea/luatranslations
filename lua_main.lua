local input = {
    greeting = {
        eng = "Hello World!",
        swe = "Hallå Världen!",
        ger = "Hallo Welt!",
        lorem = "Lorem ipsum!",
        text_id = 1
    },
    headline = {
        eng = "This is a headline.",
        swe = "Det här en rubrik.",
        ger = "Dies ist eine Überschrift.",
        lorem = "Dolor sit amet.",
        text_id = 2
    },
    content = {
        eng = "This is the main content. It consists of two sentences.",
        swe = "Det här är huvudinnehållet. Det består av två meningar.",
        ger = "Dies ist der Hauptinhalt. Er besteht aus zwei Sätzen.",
        lorem = "Quisque at luctus libero. Lorem ipsum dolor sit amet.",
        text_id = 3
    },
    footer = {
        eng = "Last updated: February 15 2024.",
        swe = "Senast uppdaterad: 15 februari 2024.",
        ger = "Zuletzt aktualisiert: 15. Februar 2024.",
        lorem = "Donec iaculis facilisis: Jan 1 1970.",
        text_id = 4
    }
}

local lang_id = "lorem"

-- Keyed table with keys [value] and [text_id] from input based on lang_id
local output = {}

-- Check if lang_id is valid key in input table
function HasKey(key)
    print(input.content[key])
    return input.content[key] ~= nil
end

-- Check if given string is longer than 20 chars
function CheckLength(string)
    return #string > 20
end

function CreateOutput() 
    -- Pick the languange "lorem" if lang_id is missing or language doesn't exist.
    if (HasKey(lang_id)) then
        print('Key exists: ', lang_id)
    else
        lang_id = "lorem"
    end

    Out = {}
    for k, v in pairs(input) do
        Out[k] = {}
        for f, val in pairs(v) do
            if f == lang_id then
                Out[k] = { ['value'] = val, ['text_id'] = input[k].text_id, }
            end
        end
    end

    -- Check string value length, add shortened_text key if length > 20
    for k, v in pairs(Out) do
        if(CheckLength(v.value)) then
            Out[k].shortened_text =  string.sub(v.value, 1, 17) .. '...'
        end
    end

    return Out
end

output = CreateOutput()


-- Array table where the strings are stored and ordered by text_id from lowest to highest id.
local ordered_by_id = {}

function OrderById()
    Sortable = {}
    for k, v in pairs(output) do
        table.insert(Sortable, v)
        table.sort(Sortable, function(valA, valB)
            return valA.text_id < valB.text_id
        end)
    end

    Out = {}
    for f, val in pairs(Sortable) do
        table.insert(Out, val.value)
    end
    return Out
end

ordered_by_id = OrderById()

-- Array table where the strings are stored and sorted from fewest characters to most characters.
local sorted_by_length = {}

for k, v in pairs(ordered_by_id) do
    table.insert(sorted_by_length, v)
    table.sort(sorted_by_length, function(valA, valB)
        return #valA < #valB
    end)
end

-- Random func for printing out tables
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

print(dump(output))
print(dump(ordered_by_id))
print(dump(sorted_by_length))
