local dirt = love.graphics.newImage("tile-images/dirt.png")
local grass = love.graphics.newImage("tile-images/grass.png")
local roadltr = love.graphics.newImage("tile-images/road-left-to-right.png")
local roadrtl = love.graphics.newImage("tile-images/road-right-to-left.png")
local crossroad = love.graphics.newImage("tile-images/crossroad.png")
local signpost = love.graphics.newImage("tile-images/signpost.png")
local tileset = {grass, dirt, roadltr, roadrtl, crossroad, signpost}

return tileset
