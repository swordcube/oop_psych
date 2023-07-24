local MathUtil = {}

---
--- Returns if a number is NaN.
---
---@param n number  The number to check.
---
MathUtil.isNaN = function(n)
    return (n ~= n)
end

---
--- Round a decimal number to have reduced precision (less decimal numbers).
---
--- @param num      number   The number to round.
--- @param decimals integer  Number of decimals the result should have.
---
MathUtil.roundDecimal = function(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

---
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