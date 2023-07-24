local Class = require("libs/oop_psych/Class")
local Sprite = require("libs/oop_psych/Sprite")
local StringUtil = require("libs/oop_psych/utils/StringUtil")

local TweenManager = require("libs/oop_psych/managers/TweenManager")
local KeyboardManager = require("libs/oop_psych/managers/KeyboardManager")
local FunkinControls = require("libs/oop_psych/managers/FunkinControls")

--## THE GAME HELPERS

local Game = {
    __connectedFuncs__ = {},
    keys = KeyboardManager.create(),
    controls = FunkinControls.create(),

    boyfriend = Sprite.fromTag('boyfriend'),
    gf = Sprite.fromTag('gf'),
    dad = Sprite.fromTag('dad'),

    timeBar = Sprite.fromTag('timeBar'),
    timeBarBG = Sprite.fromTag('timeBarBG'),
    timeTxt = Sprite.fromTag('timeTxt'),

    healthBar = Sprite.fromTag('healthBar'),
    healthBarBG = Sprite.fromTag('healthBarBG'),

    scoreTxt = Sprite.fromTag('scoreTxt'),
    iconP1 = Sprite.fromTag('iconP1'),
    iconP2 = Sprite.fromTag('iconP2'),
}

Game.connect = function(name, func)
    if Game.__connectedFuncs__[name] == nil then
        Game.__connectedFuncs__[name] = {}
    end
    table.insert(Game.__connectedFuncs__[name], func)
    if name == "onCreate" or name == "onUpdate" then return end

    local _o = _G[name]
    _G[name] = function(...)
        if _o then _o(...) end
        return Game.call(name, ...)
    end
end

Game.get = function(property)
    return getProperty(property)
end

Game.set = function(property, value)
    setProperty(property, value)
end

Game.call = function(name, ...)
    local returnVal = nil

    for _, value in pairs(Game.__connectedFuncs__[name]) do
        if not value then goto continue end
        local _ret = value(...)
        if _ret ~= null then
            returnVal = _ret
        end
        ::continue::
    end

    return returnVal
end

--## private, do NOT use! ##--
TweenManager.globalManager = TweenManager.create()

Game.__update__ = function(elapsed)
    TweenManager.globalManager.update(elapsed)
end

local _o = onCreate
onCreate = function()
    _G.hasUpdatedPsych = StringUtil.startsWith(version, "0.7")

    _G.FlxG = Class.from("flixel.FlxG")
    _G.FlxSprite = Class.from("flixel.FlxSprite")
    _G.ClientPrefs = Class.from(_G.hasUpdatedPsych and "backend.ClientPrefs" or "ClientPrefs")
    _G.Conductor = Class.from(_G.hasUpdatedPsych and "backend.Conductor" or "Conductor")

    if _o then _o() end
    Game.call("onCreate")
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