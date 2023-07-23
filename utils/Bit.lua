local Bit = {}

Bit.lshift = function(x, by)
    return x * 2 ^ by
end

Bit.rshift = function(x, by)
    return math.floor(x / 2 ^ by)
end

Bit.band = function(x, y)
    local p = 1
    local result = 0
    while x > 0 and y > 0 do
        local rx = x % 2
        local ry = y % 2
        if rx == 1 and ry == 1 then
            result = result + p
        end
        p = p * 2
        x = math.floor(x / 2)
        y = math.floor(y / 2)
    end
    return result
end

Bit.bor = function(x, y)
    local p = 1
    local result = 0
    while x > 0 or y > 0 do
        local rx = x % 2
        local ry = y % 2
        if rx == 1 or ry == 1 then
            result = result + p
        end
        p = p * 2
        x = math.floor(x / 2)
        y = math.floor(y / 2)
    end
    return result
end

Bit.tohex = function(num)
    local hexstr = '0123456789abcdef'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = hexstr:sub(mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return s
end

Bit.tobit = function(num)
    num = Bit.band(num, 0xffffffff)
    if num >= 0x80000000 then
      num = num - 0x100000000
    end
    return num
end

return Bit