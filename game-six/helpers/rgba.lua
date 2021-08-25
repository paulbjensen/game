--[[
    A helper function that transforms RGBA values into the number format used
    by Löve2D
]]
local rgba = function(r, g, b, a)
    local red = (1 / 255) * r
    local green = (1 / 255) * g
    local blue = (1 / 255) * b
    return {red, green, blue, a}
end

return rgba
