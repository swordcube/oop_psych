local StringUtil = require("libs/oop_psych/utils/StringUtil")
local FunkinControls = {}

FunkinControls.create = function()
    local manager = {}

    setmetatable(manager, {
        -- getter
        __index = function(_, action)
            if StringUtil.startsWith(version, "0.7") then
                return getPropertyFromClass("backend.Controls", "instance."..action)
            else
                -- backwards compatibility
                return getPropertyFromClass("flixel.FlxG", "state.controls."..action)
            end
        end
    })

    return manager
end

return FunkinControls