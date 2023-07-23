local TweenManager = require("libs/oop_psych/managers/TweenManager")
local MathUtil = require("libs/oop_psych/utils/MathUtil")
local Tween = {
    --- Runs a tween on a specified sprite.
    ---
    --- @param object     table     The sprite
    --- @param properties table     The properties of the sprite to tween
    --- @param duration   number    How long this tween should last for
    --- @param easing     function  The easing function applied to the tween while it is running.
    --- @param startDelay number    The properties of the sprite to tween
    ---
    run = function(object, properties, duration, easing, startDelay)
        local tween = {
            ["object"] = object,
            ["properties"] = properties,
            ["duration"] = duration,
            ["easing"] = easing,
            ["startDelay"] = startDelay,
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

        tween.destroy = function()
            TweenManager.globalManager.remove(tween)
            tween = nil
        end

        tween.update = function(elapsed)
            if tween.finished or tween.paused then return end

            if tween.startTimer < tween.startDelay then
                local t = tween.startTimer
                tween.startTimer = t + elapsed
                return
            end

            if tween.progress > 1 then
                tween.stop()
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
}
return Tween