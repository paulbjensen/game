-- Camera

local Object = require "lib.helpers.classic"
local Camera = Object:extend()

function Camera:new()
    self.offset = {x = 0, y = 0}
    self.zoom_level = 1
end

function Camera:zoom_in()
    self.zoom_level = self.zoom_level * 1.1
end

function Camera:zoom_out()
    self.zoom_level = self.zoom_level * 0.9
end

function Camera:reset_zoom()
    self.zoom_level = 1
end

function Camera:move_left(factor)
    self.offset.x = self.offset.x + factor
end

function Camera:move_right(factor)
    self.offset.x = self.offset.x - factor
end

function Camera:move_up(factor)
    self.offset.y = self.offset.y + factor
end

function Camera:move_down(factor)
    self.offset.y = self.offset.y - factor
end

return Camera
