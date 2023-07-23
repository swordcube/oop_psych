local TweenManager = require("libs/oop_psych/tweens/TweenManager")
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
        tween.active = true
        tween.startTimer = 0
        tween.progress = 0
        
        --## funcs ##--
        tween.restart = function()
            tween.finished = false
            tween.active = true
            tween.startTimer = 0
            tween.progress = 0
        end

        tween.update = function(elapsed)
            if tween.finished or not tween.active then return end

            if tween.startTimer < tween.startDelay then
                local t = tween.startTimer
                tween.startTimer = t + elapsed
                return
            end

            if tween.progress > 1 then
                TweenManager.globalManager.remove(tween)
                tween.finished = true
                return
            end
            tween.progress = tween.progress + (elapsed / tween.duration)
            for key, value in pairs(tween.properties) do
                local initial = tween.initialProperties[key]
                local ratio = tween.progress > 1 and 1 or tween.progress
                tween.object[key] = MathUtil.lerp(initial, value, tween.easing(ratio))
            end
        end

        tween.pause = function()
            tween.active = false
        end

        tween.resume = function()
            tween.active = true
        end

        tween.stop = function()
            tween.finished = true
            tween.active = false
            tween.startTimer = 0
            tween.progress = 0
        end

        TweenManager.globalManager.add(tween)

        return tween
    end
}
return Tween