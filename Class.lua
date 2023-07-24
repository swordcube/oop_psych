local Class = {}

Class.from = function(cl)
    local class = {
        __class__ = cl,
    }

    setmetatable(class, {
        __index = function(_, property)
            return getPropertyFromClass(class.__class__, property)
        end,
        __newindex = function(_, property, value)
            return setPropertyFromClass(class.__class__, property, value)
        end
    })

    return class
end

return Class