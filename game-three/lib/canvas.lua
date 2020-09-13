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
    -- x,y are numbers from 1 to grid_size (e.g. 20)
    local image_x = (self.grid_x / camera.zoom_level) + ((y - x) * (tileset.block_width / 2))
    --               568 + ((1-1) * 32)     = 568
    --               568 + ((0) * 32)       = 568
    --               568 + (0)              = 568

    --               568 + ((2-1) * 32)     = 600
    --               568 + ((1) * 32)       = 600
    --               568 + (32)             = 600

    local image_y =
        (self.grid_y / camera.zoom_level) + ((x + y) * (tileset.block_height / 2)) -
        (tileset.block_height * (map.grid_size / 2))
    love.graphics.draw(image, image_x, image_y)
    --love.graphics.rectangle('line', image_x, image_y, 64, 32)
    
    local vertices = {

        image_x + (tileset.block_width / 2),
        image_y,
        image_x + tileset.block_width,
        image_y + (tileset.block_height / 2),
        image_x + (tileset.block_width / 2),
        image_y + tileset.block_height,
        image_x,
        image_y + (tileset.block_height / 2),

        -- image_x,
        -- image_y - (tileset.block_height / 2),
        -- image_x + (tileset.block_width / 2),
        -- image_y,
        -- image_x,
        -- image_y + (tileset.block_height / 2),
        -- image_x - (tileset.block_width / 2),
        -- image_y
    }
    love.graphics.polygon("line", vertices)


    -- love.graphics.circle("line", image_x, image_y, 2)
    -- love.graphics.print(x .. "," .. y, image_x, image_y)
end

-- Base off of the draw tile - work in progress
function Canvas:highlightGridItemFromMouseCoord(x, y, width, height, camera, tileset, map)
    -- turn x,y into 1-20, 1-20 grid coords

    -- 1,1
    local example_x = 600
    local example_y = 96

    -- 1,2
    -- local example_x = 600
    -- local example_y = 96
    -- local a = (x - ((self.grid_x) + ((y - self.grid_y ) * 2))) -- we need to account for y too as it impacts the offset of grid_x) - aha
    -- local a = math.ceil(((((self.grid_x + tileset.block_width) - ((y - self.grid_y) * 2))) - x) / tileset.block_width) -- 9 to -9
    local grid_size = {tileset.block_width * map.grid_size, tileset.block_height * map.grid_size}
    local a = x
    local b = y
    love.graphics.print(
        self.grid_x .. ' , '.. self.grid_y .. ' | ' .. x .. ' , ' .. y .. ' | ' .. a .. ' , ' .. b .. ' | ' .. grid_size[1] .. ' , ' .. grid_size[2],
        10 / camera.zoom_level,
        10 / camera.zoom_level,
        0,
        camera.zoom_level,
        camera.zoom_level,
        camera.offset.x / camera.zoom_level,
        camera.offset.y / camera.zoom_level
    )

    -- local a = (self.grid_x / camera.zoom_level) + ((y - x) * (tileset.block_width / 2))
    -- local b =
    --     (self.grid_y / camera.zoom_level) + ((x + y) * (tileset.block_height / 2)) -
    --     (tileset.block_height * (map.grid_size / 2))

    -- local vertices = {
    --     a,
    --     b - (height / 2),
    --     a + (width / 2),
    --     b,
    --     a,
    --     b + (height / 2),
    --     a - (width / 2),
    --     b
    -- }
    -- love.graphics.polygon("line", vertices)
    --[[
        This works, but now need to work out from the coordinates what the 
        selected tile would be, and calculate the vertices to overlay on that
    ]]
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
