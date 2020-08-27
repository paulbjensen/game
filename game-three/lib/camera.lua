--[[
    Camera

    This controls the main camera for the game, allowing you to:
    - move the camera up, down, left, right, and diagonally
    - center the camera
    - zoom in and out dynamic (not at fixed ranges)
    - reset the zoom level
    - apply the camera settings (both zoom level and camera position)
]] 

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

function Camera:center()
    self.offset = {x = 0, y = 0}
end

-- Note - might be worth putting these into a Mouse class
function Camera:getMousePosition()
	local mouse_x, mouse_y = love.mouse.getPosition()
	local actual_mouse_x = (mouse_x / self.zoom_level) - self.offset.x
    local actual_mouse_y = (mouse_y / self.zoom_level) - self.offset.y
    return { actual_mouse_x, actual_mouse_y }
end

-- draws a circle with 1px thickness and 10px radius - used to track position when camera adjusts position and zoom
function Camera:displayMousePosition()
    local mouse_coordinates = self:getMousePosition()
    love.graphics.setLineWidth(1/ self.zoom_level)
    love.graphics.circle("line", mouse_coordinates[1], mouse_coordinates[2], 10 / self.zoom_level)
end

function Camera:apply()
    love.graphics.scale(self.zoom_level)
    love.graphics.translate(self.offset.x, self.offset.y)
end

return Camera
