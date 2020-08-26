-- Canvas

local Object = require "lib.helpers.classic"
local Canvas = Object:extend()

function Canvas:new()
    self.window_width = nil
    self.window_height = nil
    self.grid_x = nil
    self.grid_y = nil
end

function Canvas:apply(tileset, camera)
    self.window_width, self.window_height = love.graphics.getDimensions()
    self.grid_x = (self.window_width / 2) - ((tileset.block_width / 2) * camera.zoom_level)
    self.grid_y = (self.window_height / 2) - ((tileset.block_height) * camera.zoom_level)
end

return Canvas
