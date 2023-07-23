local TableUtil = {}

--- Makes a new table and copies the contents of another
--- specified `table` into it.
---
---@param table     table    The table to copy.
---@param recursive boolean  Whether or not to copy child tables of the specified `table` into the new table.
---
TableUtil.copy = function(table, recursive)
    local t = {}
    for index, value in pairs(table) do
        t[index] = (recursive and type(value) == 'table') and TableUtil.copy(value, recursive) or value
    end
    return t
end

return TableUtil