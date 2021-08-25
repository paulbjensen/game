-- Dependencies
local Object = require("helpers.classic")
local rgba = require("helpers.rgba")

-- Button class
local Button = Object:extend()

-- Instance method
function Button:new(width, height, x, y, text, on_press, on_hover, on_blur)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    self.text = text
    self.on_press = on_press
    self.on_hover = on_hover
    self.on_blur = on_blur
    self.hover = false
end

function Button:draw()
    -- Draw the button shadow layer first
    local shadow_color = rgba(26, 75, 0, 0.5)
    love.graphics.setColor(unpack(shadow_color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height + 4, 4, 4)

    -- Define possible button colors
    local button_color = rgba(87, 200, 0, 1)
    local button_hover_color = rgba(102, 247, 0, 1)

    -- Set the button background depending on the button hover state
    local button_background
    if self.hover == true then
        button_background = button_hover_color
    else
        button_background = button_color
    end

    -- Draw the button background layer
    love.graphics.setColor(unpack(button_background))
    love.graphics.rectangle(
        "fill",
        self.x, -- center of screen
        self.y, -- center of screen
        self.width,
        self.height,
        4,
        4
    )

    -- Draw the button text
    local text_color = rgba(255, 255, 255, 1)
    love.graphics.setColor(unpack(text_color))
    local font = love.graphics.getFont()
    local font_height = font:getHeight()
    love.graphics.printf(self.text, self.x, self.y + ((self.height - font_height) / 2), self.width, "center")
end

function Button:within_dimensions(x, y)
    local button_x_start = self.x
    local button_x_end = self.x + self.width
    local button_y_start = self.y
    local button_y_end = self.y + self.height
    if (x >= button_x_start and x <= button_x_end and y >= button_y_start and y <= button_y_end) then
        return true
    else
        return false
    end
end

return Button
