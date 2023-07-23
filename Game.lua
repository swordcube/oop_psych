local TweenManager = require("libs/oop_psych/managers/TweenManager")
local KeyboardManager = require("libs/oop_psych/managers/KeyboardManager")
local FunkinControls = require("libs/oop_psych/managers/FunkinControls")

local Game = {
    __connectedFuncs__ = {},
    keys = KeyboardManager.create(),
    controls = FunkinControls.create()
}

TweenManager.globalManager = TweenManager.create()

Game.connect = function(name, func)
    if Game.__connectedFuncs__[name] == nil then
        Game.__connectedFuncs__[name] = {}
    end
    table.insert(Game.__connectedFuncs__[name], func)
    if name == "onUpdate" then return end

    local _o = _G[name]
    _G[name] = function(...)
        if _o then _o(...) end
        Game.call(name, ...)
    end
end

Game.call = function(name, ...)
    for _, value in pairs(Game.__connectedFuncs__[name]) do
        if not value then goto continue end
        value(...)
        ::continue::
    end
end

--## private, do NOT use! ##--
Game.__update__ = function(elapsed)
    TweenManager.globalManager.update(elapsed)
end

local _o = onUpdate
onUpdate = function(elapsed)
    if _o then _o(elapsed) end
    Game.__update__(elapsed)
    Game.call("onUpdate", elapsed)
end

setmetatable(Game, {
    -- getter
    __index = function(_, property)
        return getProperty(property)
    end,
    -- setter
    __newindex = function(_, property, value)
        setProperty(property, value)
    end
})

return Game