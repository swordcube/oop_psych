local TweenManager = {
    globalManager = nil
}

TweenManager.create = function()
    local manager = {
        ["tweens"] = {}
    }

    manager.add = function(tween)
        table.insert(manager.tweens, tween)
    end

    manager.remove = function(tween)
        for index, value in ipairs(manager.tweens) do
            if value ~= tween then goto continue end
            table.remove(manager.tweens, index)
            ::continue::
        end
    end

    manager.update = function(elapsed)
        for _, tween in ipairs(manager.tweens) do
            tween.update(elapsed)
        end
    end

    return manager
end

return TweenManager
