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
        ["tag"] = tag,
        ["__destroyed__"] = false
    }
    sprite.animation = AnimationController.create(sprite)

    if x ~= nil or y ~= nil then
        makeLuaSprite(tag, nil, x, y)
    end

    --## INITIALIZING THE FUNCTIONS ##--
    
    ---
    --- Loads any specified frames/atlas onto this sprite.
    ---
    --- @param name       string   The name of the frames/atlas to load.
    --- @param atlasType  string   The type of frames/atlas (`sparrow`, `packer`, or `textureatlas`)
    ---
    sprite.loadFrames = function(name, atlasType)
        if sprite.__destroyed__ then return sprite end
        loadFrames(sprite.tag, name, atlasType ~= nil and string.lower(atlasType) or "sparrow")
        return sprite
    end

    ---
    --- Loads any specified graphic onto this sprite.
    ---
    --- @param name   string   The name of the graphic to load.
    --- @param width  integer  The width of each tile (for spritesheets, optional)
    --- @param height integer  The width of each tile (for spritesheets, optional)
    ---
    sprite.loadGraphic = function(name, width, height)
        if sprite.__destroyed__ then return sprite end
        loadGraphic(sprite.tag, name, width, height)
        return sprite
    end
    
    ---
    --- Sets the X and Y position of a sprite to anything specified.
    ---
    --- @param x number  The X position to set.
    --- @param y number  The Y position to set.
    ---
    sprite.setPosition = function(x, y)
        if sprite.__destroyed__ then return sprite end
        sprite.x = x
        sprite.y = y
        return sprite
    end

    ---
    --- Sets the X and Y scale of a sprite to anything specified.
    --- It might make sense to call `updateHitbox()` afterwards!
    ---
    --- @param x number  The X scale to set.
    --- @param y number  The Y scale to set.
    ---
    sprite.setScale = function(x, y)
        if sprite.__destroyed__ then return sprite end
        if y == nil then y = x end
        sprite["scale.x"] = x
        sprite["scale.y"] = y
        return sprite
    end

    ---
    --- Helper function to set the graphic's dimensions by using `scale`, allowing you to keep the current aspect ratio
    --- should one of the Integers be `<= 0`. It might make sense to call `updateHitbox()` afterwards!
    ---
    --- @param width  number  How wide the graphic should be. If `<= 0`, and `Height` is set, the aspect ratio will be kept.
    --- @param height number  How high the graphic should be. If `<= 0`, and `Width` is set, the aspect ratio will be kept.
    ---
    sprite.setGraphicSize = function(width, height)
        if sprite.__destroyed__ then return sprite end
        setGraphicSize(sprite.tag, width, height)
        return sprite
    end

    ---
    --- Immediately updates this sprite's `width`,
    --- `height`, `origin`, and `offset` values to match it's current scale.
    ---
    sprite.updateHitbox = function()
        if sprite.__destroyed__ then return sprite end
        updateHitbox(sprite.tag)
        return sprite
    end

    ---
    --- Immediately centers this sprite on a
    --- certain axes, such as:
    ---
    --- X, Y, and XY (both X & Y)
    ---
    --- @param axes table  The axes to center this sprite on.
    ---
    sprite.screenCenter = function(axes)
        if sprite.__destroyed__ then return sprite end
        if axes == nil then axes = "XY" end
        screenCenter(sprite.tag, string.upper(axes))
        return sprite
    end

    ---
    --- Immediately destroys this sprite and
    --- makes it unusable afterwards.
    ---
    sprite.destroy = function()
        if sprite.__destroyed__ then return end
        removeLuaSprite(sprite.tag, true)
        sprite.__destroyed__ = true
    end

    ---
    --- Immediately adds this sprite to the game.
    ---
    sprite.add = function()
        if sprite.__destroyed__ then return sprite end
        addLuaSprite(sprite.tag, true)
        return sprite
    end

    setmetatable(sprite, {
        -- getter
        __index = function(sprite, property)
            if sprite.__destroyed__ then return nil end
            return getProperty(sprite.tag.."."..property)
        end,
        -- setter
        __newindex = function(sprite, property, value)
            if sprite.__destroyed__ then return end
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

Sprite.fromTag = function(tag)
    return Sprite.create(tag, nil, nil)
end

return Sprite
