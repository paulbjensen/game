local dirt = love.graphics.newImage("tile-images/dirt.png")
local grass = love.graphics.newImage("tile-images/grass.png")
local roadltr = love.graphics.newImage("tile-images/road-left-to-right.png")
local roadrtl = love.graphics.newImage("tile-images/road-right-to-left.png")
local crossroad = love.graphics.newImage("tile-images/crossroad.png")
local signpost = love.graphics.newImage("tile-images/signpost.png")

local Object = require "lib.helpers.classic"
local Tileset = Object:extend()

function Tileset:new()
    self.tiles = {grass, dirt, roadltr, roadrtl, crossroad, signpost}
    self.block_width = self.tiles[1]:getWidth()
    self.block_height = self.tiles[1]:getHeight()
end

return Tileset
