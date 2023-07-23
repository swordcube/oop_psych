local LuaUtil = {}

_G.switch = function(param, cases)
    local case = cases[param]
    if not case then return nil end

    local _type = type(case)
    if _type == "function" then
        return case()
    else
        return case
    end

    return nil
end

return LuaUtil