local TweenManager = require("libs/oop_psych/managers/TweenManager")
local Ease = require("libs/oop_psych/tweens/Ease")
local MathUtil = require("libs/oop_psych/utils/MathUtil")

local Tween = {}

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
    end

    tween.destroy = function()
        TweenManager.globalManager.remove(tween)
        tween = nil
    end

    tween.update = function(elapsed)
        if tween.finished or tween.paused then return end

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
    end

    TweenManager.globalManager.add(tween)
    return tween
end

return Tween