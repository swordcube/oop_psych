local Bit = require("libs/oop_psych/utils/Bit")

local Color = {
    TRANSPARENT = 0,
	WHITE = 0xFFFFFF,
	GRAY = 0x808080,
	BLACK = 0x000000,

	GREEN = 0x008000,
	LIME = 0x00FF00,
	YELLOW = 0xFFFF00,
	ORANGE = 0xFFA500,
	RED = 0xFF0000,
	PURPLE = 0x800080,
	BLUE = 0x0000FF,
	BROWN = 0x8B4513,
	PINK = 0xFFC0CB,
	MAGENTA = 0xFF00FF,
	CYAN = 0x00FFFF
}

Color.getRGB = function(color)
	local final = {
		r = Bit.band(Bit.rshift(color, 16), 0xFF),
		g = Bit.band(Bit.rshift(color, 8), 0xFF),
		b = Bit.band(color, 0xFF),
	}
	return final
end

Color.fromRGB = function(r, g, b)
	local hex = '0x' .. string.format("%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))
	return tonumber(hex)
end

return Color