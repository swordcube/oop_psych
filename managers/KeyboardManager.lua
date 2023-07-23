local KeyboardManager = {}

KeyboardManager.create = function()
    local manager = {
        justPressed = {},
        pressed = {},
        justReleased = {},
        released = {}
    }

    setmetatable(manager.justPressed, {
        -- getter
        __index = function(_, key)
            return keyboardJustPressed(key)
        end
    })
    setmetatable(manager.pressed, {
        -- getter
        __index = function(_, key)
            return keyboardPressed(key)
        end
    })
    setmetatable(manager.justReleased, {
        -- getter
        __index = function(_, key)
            return not keyboardJustPressed(key)
        end
    })
    setmetatable(manager.released, {
        -- getter
        __index = function(_, key)
            return not keyboardReleased(key)
        end
    })

    return manager
end

return KeyboardManager