-- tiles and tileset
local Camera = require("lib.camera")
local Tileset = require("lib.tileset")
local Map = require("lib.map")
local Canvas = require("lib.canvas")
local Keyboard = require("lib.keyboard")

-- Window settings
love.window.setTitle("Shop Tycoon")
love.window.setMode(1200, 800, {resizable = true})

-- Tileset, Map, Camera, Canvas and Keyboard instantiation
local tileset = Tileset()
local map = Map()
local camera = Camera()
local canvas = Canvas()
local keyboard = Keyboard()

local keybindings = require("keybindings")
keybindings(keyboard, camera)

-- Initialises the map with populated values for the grid
map:populate()

-- determines where to render the grid based on tileset and camera settings
canvas:apply(tileset, camera)

-- applies any keyboard key presses and canvas alterations
function love.update(deltaTime)
	local factor = (500 * deltaTime)
	canvas:apply(tileset, camera)
	keyboard:apply(factor)
end

-- applies the camera settings and draws the canvas
function love.draw()
	camera:apply()
	canvas:draw(map, tileset, camera)
end
