local StringUtil = {}

--- Splits a `string` at each occurrence of `delimiter`.
---
--- @param string    string  The string to split.
--- @param delimiter string  The delimiter to split the string by.
---
StringUtil.split = function(string, delimiter)
    local result = {}

    local currentString = ""
    for i = 1, #string + 1 do
        local character = string:sub(i,i)
        if delimiter ~= nil and #delimiter > 0 then
            if character == delimiter or character == "" or character == nil then
                table.insert(result, currentString)
                currentString = ""
                goto continue
            end
            currentString = currentString .. character
            ::continue::
        else
            table.insert(result, character)
        end
    end

    if #result[#result] < 1 then
        table.remove(result, #result)
    end

    return result
end

--- Trims the left and right ends of this `string`
--- to remove invalid characters.
---
---@param string string  The string to trim.
---
StringUtil.trim = function(string)
    return string:gsub("^%s*(.-)%s*$", "%1")
end

--- Returns if the contents of a `string` contains the
--- contents of another `string`. 
---
--- @param string string  The string to check.
--- @param value  string  What `string` should contain.
---
StringUtil.contains = function (string, value)
    return string:find(value, 1, true) ~= nil
end

--- Returns if the contents of a `string` starts with the
--- contents of another `string`. 
---
--- @param string string  The string to check.
--- @param start  string  What `string` should start with.
---
StringUtil.startsWith = function(string, start)
    return string:sub(1, #start) == start
end

--- Returns if the contents of a `string` ends with the
--- contents of another `string`. 
---
--- @param string string  The string to check.
--- @param ending string  What `string` should end with.
---
StringUtil.endsWith = function(string, ending)
    return ending == "" or string:sub(-#ending) == ending
end

--- Replaces all occurrences of `from` in a `string` with
--- the contents of `to`.
---
--- @param string string  The string to check.
--- @param from   string  The content to be replaced with `to`.
--- @param to     string  The content to replace `from` with.
---
StringUtil.replace = function(string, from, to)
    local search_start_idx = 1

    while true do
        local start_idx, end_idx = string:find(from, search_start_idx, true)
        if (not start_idx) then
            break
        end

        local postfix = string:sub(end_idx + 1)
        string = string:sub(1, (start_idx - 1)) .. to .. postfix

        search_start_idx = -1 * postfix:len()
    end

    return s
end

--- Inserts any given string into another `string`
--- starting at a given character position.

--- @param string string   The string to have content inserted into.
--- @param pos    integer  The character position to insert the new content.
--- @param text   string   The content to insert.
---
StringUtil.insert = function(string, pos, text)
    return string:sub(1, pos - 1) .. text .. string:sub(pos)
end

return StringUtil