function love.load()
    require "rectangle"
    love.window.setTitle("My app")
    love.window.setMode(1200, 800, {resizable = true})
    objects = {}

    for i = 1, 800 do
        local rect = Rectangle(math.random(1, 1200), math.random(1, 800), 5, 5)
        table.insert(objects, rect)
    end
end

function love.update(dt)
    for i = 1, #objects do
        objects[i]:update(dt)
    end
end

function love.draw()
    for i = 1, #objects do
        objects[i]:draw()
    end
end
