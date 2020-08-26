-- tiles and tileset
local Camera = require("lib.camera")
local Tileset = require("lib.tileset")
local Map = require("lib.map")
local Canvas = require("lib.canvas")
local Keyboard = require("lib.keyboard")

-- Window settings
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})

-- Tileset, Map and Camera instantiation
local tileset = Tileset()
local map = Map()
local camera = Camera()
local canvas = Canvas()
local keyboard = Keyboard()

-- Initialises the map with populated values for the grid
map:populate()

-- determines where to render the grid based on tileset and camera settings
canvas:apply(tileset, camera)

keyboard:add(
	"right",
	function(f)
		camera:move_right(f)
	end
)

-- NOTE - would be nice to have some kind of key mapping table instead of multiple if statements
-- seems like it will not save many lines of code at all

function apply_keyboard_bindings(factor)
	-- pans the camera to the right
	-- if love.keyboard.isDown("right") then
	-- 	camera:move_right(factor)
	-- end

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

function love.update(deltaTime)
	local factor = (500 * deltaTime)
	canvas:apply(tileset, camera)
	apply_keyboard_bindings(factor)
	keyboard:apply(factor)
end

function love.draw()
	camera:apply()
	canvas:draw(map, tileset, camera)
end
