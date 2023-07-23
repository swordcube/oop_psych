local AnimationController = require("libs/oop_psych/animation/AnimationController")
local LuaUtil = require("libs/oop_psych/utils/LuaUtil")

local Sprite = {}

--- Creates a new sprite with at any
--- specified X & Y position.
---
--- @param tag string  The tag this sprite should internally have. This is important.
--- @param x   number  The X position of this sprite.
--- @param y   number  The Y position of this sprite.
---
Sprite.create = function(tag, x, y)
    --## INITIALIZING THE SPRITE ##--

    local sprite = {
        ["tag"] = tag
    }
    sprite.animation = AnimationController.create(sprite)
    
    makeLuaSprite(tag, nil, x, y)

    --## INITIALIZING THE FUNCTIONS ##--

    sprite.loadGraphic = function(name, width, height)
        loadGraphic(sprite.tag, name, width, height)
        return sprite
    end
    
    sprite.setPosition = function(x, y)
        sprite.x = x
        sprite.y = y
    end

    sprite.setGraphicSize = function(width, height)
        setGraphicSize(sprite.tag, width, height)
    end

    sprite.updateHitbox = function()
        updateHitbox(sprite.tag)
    end

    sprite.screenCenter = function(axes)
        if axes == nil then axes = "XY" end
        screenCenter(sprite.tag, string.upper(axes))
    end

    sprite.destroy = function()
        removeLuaSprite(sprite.tag, true)
        sprite = nil
    end

    sprite.add = function()
        addLuaSprite(sprite.tag, true)
    end

    setmetatable(sprite, {
        -- getter
        __index = function(sprite, property)
            return getProperty(sprite.tag.."."..property)
        end,
        -- setter
        __newindex = function(sprite, property, value)
            local overrideSet = false
            switch(property, {
                ["camera"] = function()
                    overrideSet = true
                    setObjectCamera(sprite.tag, value)
                end
            })
            if overrideSet then return end
            setProperty(sprite.tag.."."..property, value)
        end
    })

    --## RETURNING THE SPRITE ##--

    return sprite
end

return Sprite
