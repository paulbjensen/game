-- Keyboard

local Object = require "lib.helpers.classic"
local Keyboard = Object:extend()

function Keyboard:new()
    self.keybindings = {}
end

function Keyboard:add(k, func)
    self.keybindings[k] = func
end

function Keyboard:apply(factor)
    for k, func in pairs(self.keybindings) do
        if love.keyboard.isDown(k) then
            func(factor)
        end
    end
end

return Keyboard
