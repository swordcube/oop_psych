local File = {}

File.save = function(file, content)
    local f = io.open(file, 'wb')
    f:write(content)
    return f, f:close()
end
File.getContent = function(file)
    local f = io.open(file, 'rb')
    local content = f:read('*all')
    f:close()
    return content
end
File.exists = function(file)
    local f = io.open(file, 'r')
    if f ~= nil then 
        f:close()
        return true
    end
    return false
end
File.getScriptPath = function()
    return debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]]
end

return File