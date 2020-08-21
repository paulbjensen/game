-- Rectangle

Object = require "classic"

Rectangle = Object:extend()

function Rectangle:new(x, y, width, height)
    self.x = x
    self.y = y

    self.width = width
    self.height = height
    self.speed = 100
end

function Rectangle:update(dt)
    local xOperand = 1
    local yOperand = 1
    if (math.random() > 0.5) then
        xOperand = -1
    end
    if (math.random() > 0.5) then
        yOperand = -1
    end

    self.y = self.y + ((self.speed * dt) * yOperand)
    self.x = self.x + ((self.speed * dt) * xOperand)
end

function Rectangle:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end
