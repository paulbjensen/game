-- Dependencies
local BankAccount = require("lib.bank_account")

describe(
    "Bank account",
    function()
        describe(
            "instantiating an instance",
            function()
                local bank_account = BankAccount()

                it(
                    "should have a balance of 0",
                    function()
                        assert.equal(bank_account.balance, 0)
                    end
                )

                it(
                    "should have an empty list of transactions",
                    function()
                        local count = #bank_account.transactions
                        assert.equal(count, 0)
                    end
                )
            end
        )

        describe(
            ":add_transaction",
            function()
                describe(
                    "when the transaction has the type credit",
                    function()
                        it(
                            "should increase the bank balance by the amount of the transaction",
                            function()
                                local bank_account = BankAccount()
                                local transaction = {type = "credit", amount = 1000, description = "share capital"}
                                bank_account:add_transaction(transaction)
                                assert.equal(bank_account.balance, 1000)
                            end
                        )
                    end
                )

                describe(
                    "when the transaction has the type debit",
                    function()
                        it(
                            "should decrease the bank balance by the amount of the transaction",
                            function()
                                local bank_account = BankAccount()
                                local transaction = {type = "debit", amount = 500, description = "inventory purchase"}
                                bank_account:add_transaction(transaction)
                                assert.equal(bank_account.balance, -500)
                            end
                        )
                    end
                )
            end
        )

        describe(
            ":can_afford_transaction",
            function()
                describe(
                    "when the transaction type is credit",
                    function()
                        it(
                            "should return true",
                            function()
                                local bank_account = BankAccount()
                                local transaction = {type = "credit", amount = 250, description = "Working capital"}
                                local affordable = bank_account:can_afford_transaction(transaction)
                                assert.equal(affordable, true)
                            end
                        )
                    end
                )

                describe(
                    "when the amount is more than what is available in the bank",
                    function()
                        it(
                            "should return false",
                            function()
                                local bank_account = BankAccount()
                                local transaction = {
                                    type = "debit",
                                    amount = 10000,
                                    description = "Bulk inventory purchase"
                                }
                                local affordable = bank_account:can_afford_transaction(transaction)
                                assert.equal(affordable, false)
                            end
                        )
                    end
                )

                describe(
                    "when the amount is less than what is available in the bank",
                    function()
                        it(
                            "should return true",
                            function()
                                local bank_account = BankAccount()
                                local working_capital = {type = "credit", amount = 250, description = "Working capital"}
                                bank_account:add_transaction(working_capital)
                                local transaction = {
                                    type = "debit",
                                    amount = 100,
                                    description = "Small inventory purchase"
                                }
                                local affordable = bank_account:can_afford_transaction(transaction)
                                assert.equal(affordable, true)
                            end
                        )
                    end
                )
            end
        )
    end
)
