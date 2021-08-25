-- Dependencies
local rgba = require("helpers.rgba")
local config = require("config")
local app_state = require("app_state")

-- Set the screens on the app_state (be nice to move this into some kind of function)
local welcome = require("screens.welcome")
local new_game = require("screens.new-game")
app_state.screens = {
    welcome = welcome,
    new_game = new_game
}
-- End of block

-- Window settings
love.window.setTitle(config.title)

-- Dimensions for the window
love.window.setMode(config.width, config.height, {resizable = false})

-- Draw the background
local draw_background = function()
    local background = rgba(255, 239, 224, 1)
    love.graphics.setColor(unpack(background))
    love.graphics.rectangle("fill", 0, 0, config.width, config.height)
end

-- Set the welcome screen as the 1st screen
app_state.screen = app_state.screens.welcome

function love.draw()
    draw_background()
    app_state.screen:draw()
end

--[[
    Detects if the location is on a button, and then triggers a quit if within
    range.
]]
function love.mousepressed(x, y, button)
    if button == 1 then
        app_state.screen:check_if_elements_pressed(x, y)
    end
end

--[[
    Tracks all movemouse on the screen, so that we can apply hover states on 
    buttons, and so that we can add multiple buttons onto the screen and know 
    how to handle them.
]]
function love.mousemoved(x, y)
    local show_cursor = app_state.screen:check_if_elements_hovered_over(x, y)
    local cursor = nil
    if show_cursor then
        cursor = love.mouse.getSystemCursor("hand")
    end
    love.mouse.setCursor(cursor)
end
