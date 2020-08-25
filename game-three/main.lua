local dirt = love.graphics.newImage("dirt2.png")
local grass = love.graphics.newImage("grass4.png")
local roadltr = love.graphics.newImage("road-left-to-right.png")
local roadrtl = love.graphics.newImage("road-right-to-left.png")
local crossroad = love.graphics.newImage("crossroad.png")
local signpost = love.graphics.newImage("signpost.png")
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})
local tileset = {grass, dirt, roadltr, roadrtl, crossroad, signpost}
local window_width, window_height = love.graphics.getDimensions()
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

local grid = {}
for x = 1, grid_size do
	grid[x] = {}
	for y = 1, grid_size do
		grid[x][y] = {1}

		if (x == 4) then
			grid[x][y] = {3}
		end

		if (y == 8) then
			grid[x][y] = {4}
		end

		if (x == 4 and y == 8) then
			grid[x][y] = {5}
		end
		if (x >=2 and x <= 3 and y >= 3 and y <= 5) then 
			grid[x][y] = {2, 6}
		end
	end
end

function draw_tile(image, x, y)
	love.graphics.draw(
		image,
		(grid_x / zoom_level) + ((y - x) * (block_width / 2)),
		(grid_y / zoom_level) + ((x + y) * (block_height / 2)) - (block_height * (grid_size / 2))
	)
end

function love.update()
	window_width, window_height = love.graphics.getDimensions()
	grid_x = (window_width / 2) - ((block_width / 2) * zoom_level)
	grid_y = (window_height / 2) - ((block_height / 2) * zoom_level)

	if love.keyboard.isDown("right") then
		camera_offset.x = camera_offset.x - 10
	end
	if love.keyboard.isDown("left") then
		camera_offset.x = camera_offset.x + 10
	end

	if love.keyboard.isDown("up") then
		camera_offset.y = camera_offset.y + 10
	end
	if love.keyboard.isDown("down") then
		camera_offset.y = camera_offset.y - 10
	end

	if love.keyboard.isDown("-") then
		zoom_level = zoom_level * 0.9 -- or 0.5
	end

	if love.keyboard.isDown("=") then
		zoom_level = zoom_level * 1.1 -- or 2
	end

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
