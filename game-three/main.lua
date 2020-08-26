-- tiles and tileset
local tileset = require("lib.tileset")
local Camera = require("lib.camera")

-- Window settings
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})
local window_width, window_height = love.graphics.getDimensions()

-- Tile and map settings
local block_width = tileset[1]:getWidth()
local block_height = tileset[1]:getHeight()

-- map grid settings
local grid_size = 20
local grid_x = (window_width / 2) - (block_width / 2)
local grid_y = (window_height / 2) - (block_height / 2)

-- Camera and zoom level settings
local camera = Camera()

-- Create the grid map
local grid = {}

-- this draws the initial grid map
for x = 1, grid_size do
	grid[x] = {}
	for y = 1, grid_size do
		-- sets the tile as grass
		grid[x][y] = {1}

		-- sets the tile as road (left to right)
		if (x == 4) then
			grid[x][y] = {3}
		end

		-- sets the tile as road (right to left)
		if (y == 8) then
			grid[x][y] = {4}
		end

		-- sets the tile as crossroad
		if (x == 4 and y == 8) then
			grid[x][y] = {5}
		end

		-- sets the tile as dirt, and then signpost
		if (x >= 2 and x <= 3 and y >= 3 and y <= 5) then
			grid[x][y] = {2, 6}
		end
	end
end

-- Renders a tile for the map grid coordinate
function draw_tile(image, x, y)
	love.graphics.draw(
		image,
		(grid_x / camera.zoom_level) + ((y - x) * (block_width / 2)),
		(grid_y / camera.zoom_level) + ((x + y) * (block_height / 2)) - (block_height * (grid_size / 2))
	)
end

function love.update(deltaTime)
	local factor = (500 * deltaTime)
	window_width, window_height = love.graphics.getDimensions()
	grid_x = (window_width / 2) - ((block_width / 2) * camera.zoom_level)
	grid_y = (window_height / 2) - ((block_height / 2) * camera.zoom_level)

	-- pans the camera to the right
	if love.keyboard.isDown("right") then
		camera:move_right(factor)
	end

	-- pans the camera to the left
	if love.keyboard.isDown("left") then
		camera:move_left(factor)
	end

	-- pans the camera upwards
	if love.keyboard.isDown("up") then
		camera:move_up(factor)
	end

	-- pans the camera downwards
	if love.keyboard.isDown("down") then
		camera:move_down(factor)
	end

	-- zooms the camera out
	if love.keyboard.isDown("-") then
		camera:zoom_out()
	end

	-- zooms the camera in
	if love.keyboard.isDown("=") then
		camera:zoom_in()
	end

	-- resets the camera zoom level
	if love.keyboard.isDown("0") then
		camera:reset_zoom()
	end
end

function love.draw()
	love.graphics.scale(camera.zoom_level)
	love.graphics.translate(camera.offset.x, camera.offset.y)
	for x = 1, grid_size do
		for y = 1, grid_size do
			local tiles = grid[x][y]
			for z = 1, #tiles do
				if (tileset[tiles[z]]) then
					draw_tile(tileset[tiles[z]], x, y)
				end
			end
		end
	end
end
