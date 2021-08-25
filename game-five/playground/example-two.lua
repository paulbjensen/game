-- How to start a game?

-- Define variables inside this one
local function_store = {}

-- Asks for a name, which is typed on the same line
function_store.ask_for_name = function()
    io.write("Enter your name: ")
end

-- Responds to the name input with a greeting
function_store.respond_to_name = function()
    local name = io.read()
    io.write("\nGreetings, ", name, "\n")
end

-- Asks the user to type in an option that they would like to do
function_store.ask_for_option = function()
    print("What would you like to do?\n\nOptions:\texit")
    local option = io.read()
    function_store.respond_to_option(option)
end

-- Prints a goodbye message and quits the program
function_store.exit = function()
    print("Goodbye")
    os.exit(0)
end

--[[
    Responds to the option elected by the user, or asks again in case they 
    picked an invalid option
]]
function_store.respond_to_option = function(option)
    if (type(function_store[option]) == "function") then
        function_store[option]()
    else
        print("Sorry, not a valid option")
        function_store.ask_for_option()
    end
end

-- Main app logic flow is defined here
local main = function()
    -- Note - is there a way to do CLI options on screen that can be selected?
    function_store.ask_for_name()
    function_store.respond_to_name()
    function_store.ask_for_option()
end

-- Execute the logical flow
main()

--[[
    There needs to be a sequence tree

    - Name (for when you start a new game and need to create a business)
]]
