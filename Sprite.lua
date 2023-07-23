local Sprite = {
    create = function(tag, x, y)
        --## INITIALIZING THE SPRITE ##--
        local sprite = {
            ["tag"] = tag
        }
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
        sprite.add = function()
            addLuaSprite(sprite.tag, true)
        end
        sprite.destroy = function()
            removeLuaSprite(sprite.tag, true)
            sprite = nil
        end

        setmetatable(sprite, {
            __index = function(sprite, property)
                return getProperty(sprite.tag.."."..property)
            end,
            __newindex = function(sprite, property, value)
                setProperty(sprite.tag.."."..property, value)
            end
        })

        --## RETURNING THE SPRITE ##--
        return sprite
    end
}
return Sprite
