-- Dependencies
local Object = require("helpers.classic")

-- Screen class
local Screen = Object:extend()

function Screen:new()
    self.elements = {}
end

function Screen:add_element(element)
    table.insert(self.elements, element)
end

function Screen:draw()
    for i, element in ipairs(self.elements) do
        element:draw()
    end
end

function Screen:check_if_elements_pressed(x, y)
    for i, element in ipairs(self.elements) do
        if element:within_dimensions(x, y) then
            element.on_press()
        end
    end
end

function Screen:check_if_elements_hovered_over(x, y)
    local show_cursor = false
    for i, element in ipairs(self.elements) do
        if element:within_dimensions(x, y) then
            element.on_hover(element)
            show_cursor = true
        else
            element.on_blur(element)
        end
    end
    return show_cursor
end

return Screen

--[[
    This will handle rendering a set of elements on the screen,
    binding their elements on the page, and cleaning up when finished

    Case to think of---
    how to switch from welcome screen to new game screen

    - also, what should be on the new game screen
]]
