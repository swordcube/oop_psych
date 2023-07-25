local TweenManager = require("libs/oop_psych/managers/TweenManager")
local Ease = require("libs/oop_psych/tweens/Ease")
local Color = require("libs/oop_psych/utils/Color")
local MathUtil = require("libs/oop_psych/math/MathUtil")

local Tween = {}

---
--- Runs a tween on a specified sprite.
---
--- @param object     table     The object/sprite to tween.
--- @param properties table     The properties of the sprite to tween.
--- @param duration   number    How long this tween should last for.
--- @param easing     function  The easing function applied to the tween while it is running.
--- @param options    table     A table of options for the tween.
---
Tween.run = function(object, properties, duration, easing, options)
    if easing == nil then
        easing = Ease.linear
    end
    if options == nil then
        options = {}
    end
    if object == nil then
        return
    end

    local tween = {
        ["object"] = object,
        ["properties"] = properties,
        ["duration"] = duration,
        ["easing"] = easing,
        ["options"] = options,
    }

    --## vars ##--

    tween.initialProperties = {}
    for key, _ in pairs(tween.properties) do
        tween.initialProperties[key] = tween.object[key]
    end

    tween.finished = false
    tween.paused = false
    tween.startTimer = 0
    tween.progress = 0
    
    --## funcs ##--

    tween.restart = function()
        tween.finished = false
        tween.paused = false
        tween.startTimer = 0
        tween.progress = 0
    end

    tween.pause = function()
        tween.paused = true
    end

    tween.resume = function()
        tween.paused = false
    end

    tween.stop = function()
        tween.finished = true
        tween.paused = true
        tween.startTimer = 0
        tween.progress = 0
    end

    tween.finish = function()
        if tween.options.onComplete ~= nil then
            tween.options.onComplete(tween)
        end
        tween.stop()
        tween.destroy()
    end

    tween.destroy = function()
        TweenManager.globalManager.remove(tween)
        tween = nil
    end

    tween.update = function(elapsed)
        if tween.object == nil or tween.finished or tween.paused then 
            return
        end

        local startDelay = tween.options.startDelay ~= nil and tween.options.startDelay or 0

        if tween.startTimer < startDelay then
            local t = tween.startTimer
            tween.startTimer = t + elapsed
            return
        end

        if tween.progress >= 1 then
            tween.progress = 1
            tween.finish()
            return
        end
        tween.progress = tween.progress + (elapsed / tween.duration)

        for key, value in pairs(tween.properties) do
            local initial = tween.initialProperties[key]
            local ratio = tween.progress > 1 and 1 or tween.progress
            tween.object[key] = MathUtil.lerp(initial, value, tween.easing(ratio))
        end

        if tween.options.onUpdate ~= nil then
            tween.options.onUpdate(tween)
        end
    end

    TweenManager.globalManager.add(tween)
    return tween
end

---
--- Tweens one color to another color.
---
--- @param sprite    table     The sprite to apply this color to (optional, can be set to `nil`).
--- @param from      integer   The color to tween from.
--- @param to        integer   The color to tween to.
--- @param duration  number    How long this tween should last for.
--- @param easing    function  The easing function applied to the tween while it is running (optional, can be set to `nil`).
--- @param options   table     A table of options for the tween (optional, can be set to `nil`).
---
Tween.color = function(sprite, from, to, duration, easing, options)
    local rgb = Color.getRGB(from)
    local tween = Tween.run(rgb, Color.getRGB(to), duration, easing, options)

    local _f = tween.options.onUpdate
    tween.options.onUpdate = function(t)
        if _f ~= nil then _f(t) end

        if sprite ~= nil then
            sprite.color = Color.fromRGB(rgb.r, rgb.g, rgb.b)
        end
    end
    return tween
end

Tween.stopTweensOf = function(object)
    for _, tween in pairs(TweenManager.globalManager.tweens) do
        if tween.object ~= object then goto continue end

        tween.stop()
        tween.destroy()

        ::continue::
    end
end

return Tween