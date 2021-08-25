-- Dependencies
local Business = require("lib.business")
local BankAccount = require("lib.bank_account")

describe(
    "Business",
    function()
        describe(
            "when instantiating a class",
            function()
                it(
                    "should have a name",
                    function()
                        local name = "Kwik-e mart ltd"
                        local business = Business(name)
                        assert.equal(business.name, name)
                    end
                )
                it(
                    "should raise an error if there is no name",
                    function()
                        local status, error =
                            pcall(
                            function()
                                Business()
                            end
                        )
                        assert.equal(status, false)
                        assert.equal(error, "./lib/business.lua:10: name must be provided")
                    end
                )
                it(
                    "should have a bank account",
                    function()
                        local name = "Kwik-e mart ltd"
                        local business = Business(name)
                        assert(getmetatable(business.bank_account) == BankAccount)
                        assert.equal(business.bank_account.balance, 0)
                        assert.equal(#business.bank_account.transactions, 0)
                    end
                )
            end
        )
    end
)

--[[
    What does the business consist of?

    - A Name
    - A company registration number
    - An owner
    - A director
    - A company secretary
    - A registered office
    - A trading address
    
]]
