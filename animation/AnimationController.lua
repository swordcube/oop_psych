local AnimationController = {}

AnimationController.create = function(parent)
    local controller = {
        ["parent"] = parent
    }

    ---
    --- Adds an animation to the sprite.
    ---
    --- @param name   string   The name of the new animation.
    --- @param frames table    Indicates what frames of the animation to play in whatever order (Ex: {0, 1, 2}).
    --- @param fps    integer  The framerate of the new animation (Defaults to `30`).
    --- @param loop   boolean  Whether or not the new animation should loop (Defaults to `true`).
    ---
    controller.add = function(name, frames, fps, loop)
        addAnimation(parent.tag, name, frames, fps ~= nil and fps or 30, loop ~= nil and loop or true)
    end

    ---
    --- Adds an animation to the sprite based on a
    --- prefix from it's spritesheet XML/TXT file.
    ---
    --- @param name   string   The name of the new animation.
    --- @param prefix string   The prefix to use from the spritesheet.
    --- @param fps    integer  The framerate of the new animation (Defaults to `30`).
    --- @param loop   boolean  Whether or not the new animation should loop (Defaults to `true`).
    ---
    controller.addByPrefix = function(name, prefix, fps, loop)
        addAnimationByPrefix(parent.tag, name, prefix, fps ~= nil and fps or 30, loop ~= nil and loop or true)
    end

    ---
    --- Adds an animation to the sprite based on a
    --- prefix from it's spritesheet XML/TXT file
    --- and with specific frames of the animation.
    ---
    --- @param name    string   The name of the new animation.
    --- @param prefix  string   The prefix to use from the spritesheet.
    --- @param indices table    Indicates what frames of the animation to play in whatever order (Ex: {0, 1, 2}).
    --- @param fps     integer  The framerate of the new animation (Defaults to `30`).
    --- @param loop    boolean  Whether or not the new animation should loop (Defaults to `true`).
    ---
    controller.addByIndices = function(name, prefix, indices, fps, loop)
        local indicesString = ""
        for index, value in ipairs(indices) do
            indicesString = indicesString + tostring(value)
            if index < #indices then
                indicesString = indicesString + ","
            end
        end
        addAnimationByIndices(parent.tag, name, prefix, indicesString, fps ~= nil and fps or 30, loop ~= nil and loop or true)
    end

    ---
    --- Plays an existing animation.
    ---
    --- @param name       string   The name of the animation to play.
    --- @param force      boolean  Whether or not to forcefully restart the animation (Defaults to `false`).
    --- @param reversed   boolean  Whether or not to reverse the playback of the animation (Defaults to `false`).
    --- @param startFrame integer  The frame to start playing the animation at (Defaults to `0`).
    ---
    controller.play = function(name, force, reversed, startFrame)
        playAnim(parent.tag, name, force ~= nil and force or false, reversed ~= nil and reversed or false, startFrame ~= nil and startFrame or 0)
    end

    return controller
end

return AnimationController