local Game = require("lib.game")

local game = Game()

print("\n=== Start ===\n")
game:stats()

print("\n=== Get a loan ===\n")
game:get_loan()
game:stats()

print("\n=== Order some product stock ===\n")
game:add_stock()
game:stats()

print("\n=== Sell some product stock ===\n")
game:sell()
game:stats()

-- It would be good to have an interactive REPL
-- As well as a way to charge interest
-- And a way to make product sales part of a time cycle, along with charging
-- interest
