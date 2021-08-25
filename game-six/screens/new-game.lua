local Screen = require("lib.screen")
local Button = require("lib.button")
local config = require("config")
local app_state = require("app_state")

-- Dimensions for the button
local button_width = 120
local button_height = 40

-- This is the screen. It contains multiple elements (e.g. buttons)
local screen = Screen()

-- Buttons events
local on_press = function()
    app_state.screen = app_state.screens.welcome
end
local on_hover = function(self)
    self.hover = true
end
local on_blur = function(self)
    self.hover = false
end

-- The location where the buttons will be centered in the app window
local center_point = (config.width - button_width) / 2

-- Initiate the buttons
local welcome_button =
    Button(button_width, button_height, center_point, (config.height / 2) + 64, "Back", on_press, on_hover, on_blur)
screen:add_element(welcome_button)

return screen
