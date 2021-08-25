-- Dependencies
local Object = require "lib.helpers.classic"

-- Bank Account class
local BankAccount = Object:extend()

-- Instance method
function BankAccount:new()
    self.balance = 0
    self.transactions = {}
end

-- Used to add a transaction to a bank account's list of transactions
function BankAccount:add_transaction(transaction)
    table.insert(self.transactions, transaction)
    -- Update the account balance based on the transaction type
    if transaction.type == "debit" then
        self.balance = self.balance - transaction.amount
    else
        self.balance = self.balance + transaction.amount
    end
end

function BankAccount:can_afford_transaction(transaction)
    if transaction.type == "debit" then
        return self.balance - transaction.amount >= 0
    else
        return true
    end
end

return BankAccount
