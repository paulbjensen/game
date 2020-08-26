-- tiles and tileset
local Camera = require("lib.camera")
local Tileset = require("lib.tileset")
local Map = require("lib.map")

-- Window settings
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})
local window_width, window_height = love.graphics.getDimensions()

-- Tile and map settings
local tileset = Tileset()
local map = Map()

-- Initialises the map with populated values for the grid
map:populate()

-- map grid settings
local grid_x = (window_width / 2) - (tileset.block_width / 2)
local grid_y = (window_height / 2) - (tileset.block_height / 2)

-- Camera and zoom level settings
local camera = Camera()

-- Renders a tile for the map grid coordinate
function draw_tile(image, x, y)
	love.graphics.draw(
		image,
		(grid_x / camera.zoom_level) + ((y - x) * (tileset.block_width / 2)),
		(grid_y / camera.zoom_level) + ((x + y) * (tileset.block_height / 2)) - (tileset.block_height * (map.grid_size / 2))
	)
end

function love.update(deltaTime)
	local factor = (500 * deltaTime)
	window_width, window_height = love.graphics.getDimensions()
	grid_x = (window_width / 2) - ((tileset.block_width / 2) * camera.zoom_level)
	grid_y = (window_height / 2) - ((tileset.block_height / 2) * camera.zoom_level)

	-- NOTE - would be nice to have some kind of key mapping table instead of multiple if statements
	-- seems like it will not save many lines of code at all

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
	for x = 1, map.grid_size do
		for y = 1, map.grid_size do
			local tiles = map.grid[x][y]
			for z = 1, #tiles do
				-- find a better way to name the variables here
				if (tileset.tiles[tiles[z]]) then
					draw_tile(tileset.tiles[tiles[z]], x, y)
				end
			end
		end
	end
end
