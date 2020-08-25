-- Image files for grass and dirt
-- the image files are 64 pixels wide and 32 pixels high
local dirt = love.graphics.newImage("dirt2.png")
local grass = love.graphics.newImage("grass4.png")
local roadltr = love.graphics.newImage("road-left-to-right.png")
local roadrtl = love.graphics.newImage("road-right-to-left.png")
local crossroad = love.graphics.newImage("crossroad.png")
local signpost = love.graphics.newImage("signpost.png")
love.window.setTitle('Shop Tycoon')
love.window.setMode(1200, 800, {resizable = true})

local tileset = { grass, dirt, roadltr, roadrtl, crossroad, signpost }

-- window dimensions
local window_width, window_height = love.graphics.getDimensions()

-- blocks, calculated based on an image's width and height
local block_width = grass:getWidth()
local block_height = grass:getHeight()

local block_dimension = -1 * block_width

-- the grid of tiles that we render to the screen
local grid_size = 20
local grid_x = (window_width / 2) - (block_width / 2)
local grid_y = (window_height / 2) - (block_height / 2) -- I think this is slightly knocking if off center on zoom

local camera_offset = {}
local zoom_level = 1
camera_offset.x = 0
camera_offset.y = 0

-- here we populate the grid to indicate what kind of tile we want to load at 
-- which coordinate
local grid = {}
for x = 1,grid_size do
	grid[x] = {}
	for y = 1,grid_size do
		grid[x][y] = { 1 }

		if (x == 4) then
			grid[x][y] = {3}
		end

		if (y == 8) then
			grid[x][y] = {4}
		end

		if (x == 4 and y == 8) then
			grid[x][y] = {5}
		end

	end
end

-- This draws a 2x3 grid of dirt
grid[2][3] = {2,6}
grid[2][4] = {2,6}
grid[2][5] = {2,6}
grid[3][3] = {2,6}
grid[3][4] = {2,6}
grid[3][5] = {2,6}

-- this draws the tile image at the grid coordinate
function draw_tile(image, x, y)
	love.graphics.draw(image,
	(grid_x / zoom_level) + ((y-x) * (block_width / 2)),
	(grid_y / zoom_level) + ((x+y) * (block_height / 2)) - (block_height * (grid_size / 2)))
end

function love.update()
	window_width, window_height = love.graphics.getDimensions()
	grid_x = (window_width / 2) - (block_width/2)
	grid_y = (window_height / 2) - (block_height/2)

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
		zoom_level = 0.5--//zoom_level * 0.9
	end

	if love.keyboard.isDown("=") then
		zoom_level = 2 --zoom_level * 1.1
	end

	if love.keyboard.isDown("0") then
		zoom_level = 1.0
	end

end

function love.draw()
	love.graphics.scale( zoom_level )
	love.graphics.translate(camera_offset.x, camera_offset.y)
	for x = 1,grid_size do
		for y = 1,grid_size do
			local tiles = grid[x][y]
			for z=1, #tiles do
				local tile = tileset[tiles[z]]
				if (tile) then
					draw_tile(tile, x, y)
				end
			end
		end
	end
end