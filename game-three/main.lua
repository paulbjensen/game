-- tiles and tileset

local dirt = love.graphics.newImage("dirt2.png")
local grass = love.graphics.newImage("grass4.png")
local roadltr = love.graphics.newImage("road-left-to-right.png")
local roadrtl = love.graphics.newImage("road-right-to-left.png")
local crossroad = love.graphics.newImage("crossroad.png")
local signpost = love.graphics.newImage("signpost.png")
local tileset = {grass, dirt, roadltr, roadrtl, crossroad, signpost}

-- Window settings
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})
local window_width, window_height = love.graphics.getDimensions()

-- Tile and map settings
local block_width = grass:getWidth()
local block_height = grass:getHeight()
local block_dimension = -1 * block_width
local grid_size = 20
local grid_x = (window_width / 2) - (block_width / 2)
local grid_y = (window_height / 2) - (block_height / 2)
local camera_offset = {}
local zoom_level = 1
camera_offset.x = 0
camera_offset.y = 0

-- Create the grid map
local grid = {}
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
		if (x >=2 and x <= 3 and y >= 3 and y <= 5) then 
			grid[x][y] = {2, 6}
		end
	end
end

-- Render the tile(s) for the grid coordinates
function draw_tile(image, x, y)
	love.graphics.draw(
		image,
		(grid_x / zoom_level) + ((y - x) * (block_width / 2)),
		(grid_y / zoom_level) + ((x + y) * (block_height / 2)) - (block_height * (grid_size / 2))
	)
end

function reset_zoom(difference) 
	for i = 1, 10 do
		-- would love to find a way to execute this asynchronously
		zoom_level = zoom_level - difference
		sleep(0.1)
	end
end

function love.update(deltaTime)
	local factor = (500 * deltaTime)
	window_width, window_height = love.graphics.getDimensions()
	grid_x = (window_width / 2) - ((block_width / 2) * zoom_level)
	grid_y = (window_height / 2) - ((block_height / 2) * zoom_level)

	-- pans the camera to the right
	if love.keyboard.isDown("right") then
		camera_offset.x = camera_offset.x - factor
	end

	-- pans the camera to the left
	if love.keyboard.isDown("left") then
		camera_offset.x = camera_offset.x + factor
	end

	-- pans the camera upwards
	if love.keyboard.isDown("up") then
		camera_offset.y = camera_offset.y + factor
	end

	-- pans the camera downwards
	if love.keyboard.isDown("down") then
		camera_offset.y = camera_offset.y - factor
	end

	-- zooms the camera out
	if love.keyboard.isDown("-") then
		zoom_level = zoom_level * 0.9
	end

	-- zooms the camera in
	if love.keyboard.isDown("=") then
		zoom_level = zoom_level * 1.1
	end

	-- resets the camera zoom level
	if love.keyboard.isDown("0") then
		zoom_level = 1
	end
end

function love.draw()
	love.graphics.scale(zoom_level)
	love.graphics.translate(camera_offset.x, camera_offset.y)
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
