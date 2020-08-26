-- Map

local Object = require "lib.helpers.classic"
local Map = Object:extend()

function Map:new(grid_size)
    self.grid_size = grid_size or 20
    self.grid = {}
end

function Map:populate()
    -- this draws the initial grid map
    for x = 1, self.grid_size do
        self.grid[x] = {}
        for y = 1, self.grid_size do
            -- sets the tile as grass
            self.grid[x][y] = {1}

            -- sets the tile as road (left to right)
            if (x == 4) then
                self.grid[x][y] = {3}
            end

            -- sets the tile as road (right to left)
            if (y == 8) then
                self.grid[x][y] = {4}
            end

            -- sets the tile as crossroad
            if (x == 4 and y == 8) then
                self.grid[x][y] = {5}
            end

            -- sets the tile as dirt, and then signpost
            if (x >= 2 and x <= 3 and y >= 3 and y <= 5) then
                self.grid[x][y] = {2, 6}
            end
        end
    end
end

return Map
