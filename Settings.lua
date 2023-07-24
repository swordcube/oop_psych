local Game = require("libs/oop_psych/Game")
local Settings = {}

setmetatable(Settings, {
    __index = function(_, property)
        if hasUpdatedPsych then
            return ClientPrefs["data."..property]
        else
            return ClientPrefs[property]
        end
    end,
    __newindex = function(_, property, value)
        if hasUpdatedPsych then
            ClientPrefs["data."..property] = value
        else
            ClientPrefs[property] = value
        end
    end
})

return Settings