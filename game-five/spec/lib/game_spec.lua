describe(
    "Game library",
    function()
        -- tests to here

        describe(
            "Creating an instance",
            function()
                it(
                    "should be easy to use",
                    function()
                        local Game = require("lib.game")
                        local game = Game()
                        assert.equal(game.bank_balance, 0)
                    end
                )

                pending(
                    "it should instantiate a bank account for the shop",
                    function()
                    end
                )
                pending(
                    "it should instantiate a loan amount for the shop",
                    function()
                    end
                )
                pending(
                    "it should instantiate stock levels for the shop",
                    function()
                    end
                )
            end
        )
    end
)
