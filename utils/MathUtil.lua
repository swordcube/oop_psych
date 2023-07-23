local MathUtil = {}

--- Returns if a number is NaN.
---
---@param n number  The number to check.
---
MathUtil.isNaN = function(n)
    return (n ~= n)
end

--- Linearly interpolates one value to another.
---
---@param from  number  The value to interpolate from.
---@param to    number  The value to interpolate to.
---@param ratio number  A multiplier to the amount of interpolation.\
---
MathUtil.lerp = function(from, to, ratio)
    return from + (to - from) * ratio
end

return MathUtil