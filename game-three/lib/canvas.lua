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

function Canvas:draw_tile(image, x, y, camera, tileset, map)
    love.graphics.draw(
        image,
        (self.grid_x / camera.zoom_level) + ((y - x) * (tileset.block_width / 2)),
        (self.grid_y / camera.zoom_level) + ((x + y) * (tileset.block_height / 2)) -
            (tileset.block_height * (map.grid_size / 2))
    )
end

-- Base off of the draw tile - work in progress
function Canvas:highlightGridItemFromMouseCoord(x , y, width, height, camera)
    local vertices = {
        x,
        y - (height / 2),
        x + (width / 2),
        y,
        x,
        y + (height / 2),
        x - (width / 2),
        y
    }
    love.graphics.polygon("line",vertices)
end

function Canvas:draw(map, tileset, camera)
    for x = 1, map.grid_size do
        for y = 1, map.grid_size do
            local tiles = map.grid[x][y]
            for z = 1, #tiles do
                -- find a better way to name the variables here
                if (tileset.tiles[tiles[z]]) then
                    self:draw_tile(tileset.tiles[tiles[z]], x, y, camera, tileset, map)
                end
            end
        end
    end
end

return Canvas
