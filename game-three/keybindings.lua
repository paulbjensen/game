--[[
    This is a set of keybindings that feel like game-specific configuration
    rather than a file to put in the lib directory
]]

function keybindings(keyboard, camera)
    keyboard:add(
        "right",
        function(f)
            camera:move_right(f)
        end
    )

    keyboard:add(
        "left",
        function(f)
            camera:move_left(f)
        end
    )

    keyboard:add(
        "up",
        function(f)
            camera:move_up(f)
        end
    )

    keyboard:add(
        "down",
        function(f)
            camera:move_down(f)
        end
    )

    keyboard:add(
        "c",
        function()
            camera:center()
        end
    )

    keyboard:add(
        "-",
        function()
            camera:zoom_out()
        end
    )

    keyboard:add(
        "=",
        function()
            camera:zoom_in()
        end
    )

    keyboard:add(
        "0",
        function()
            camera:reset_zoom()
        end
    )
end

return keybindings
