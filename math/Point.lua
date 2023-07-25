local Point = {}

---
--- Creates a new 2D point with an X and Y coord.
---
--- @param x number  The X coord to apply to the new point.
--- @param y number  The Y coord to apply to the new point.
---
Point.create = function(x, y)
    local point = {
        ["x"] = x,
        ["y"] = y
    }

    ---
    --- Sets the X and Y coords of this point to
    --- any specificed values.
    ---
    --- @param x number  The X coord to apply to the point.
    --- @param y number  The Y coord to apply to the point.
    ---
    point.set = function(x, y)
        point.x = x
        point.y = y
        return point
    end

    ---
    --- Adds any specified X and Y coords to this point.
    ---
    --- @param x number  The X coord to add to the point.
    --- @param y number  The Y coord to add to the point.
    ---
    point.add = function(x, y)
        -- i wish lua had += operator :(
        point.x = point.x + x
        point.y = point.y + y
        return point
    end

    ---
    --- Subtracts any specified X and Y coords to this point.
    ---
    --- @param x number  The X coord to subtract from the point.
    --- @param y number  The Y coord to subtract from the point.
    ---
    point.subtract = function(x, y)
        -- i wish lua had -= operator :(
        point.x = point.x - x
        point.y = point.y - y
        return point
    end

    ---
    --- Multiplies any specified X and Y coords to this point.
    ---
    --- @param x number  The X coord to multiply to the point.
    --- @param y number  The Y coord to multiply to the point.
    ---
    point.multiply = function(x, y)
        -- i wish lua had *= operator :(
        point.x = point.x * x
        point.y = point.y * y
        return point
    end

    ---
    --- Divides any specified X and Y coords to this point.
    ---
    --- @param x number  The X coord to divide from the point.
    --- @param y number  The Y coord to divide from the point.
    ---
    point.divide = function(x, y)
        -- i wish lua had /= operator :(
        point.x = point.x / x
        point.y = point.y / y
        return point
    end

    return point
end

return Point