local SeparatedString = {}

SeparatedString.create = function()
    local str = {
        separator = "",
        list = {}
    }

    str.add = function(line, addSeparator)
        if addSeparator == nil then addSeparator = true end
        if #str.list > 0 and addSeparator then
            table.insert(str.list, str.separator)
        end
        table.insert(str.list, line)
    end

    str.tostring = function()
        local combined = ""

        for _, value in ipairs(str.list) do
            combined = combined .. value
        end

        return combined
    end

    return str
end

return SeparatedString