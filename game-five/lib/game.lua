--[[
    Game

    This controls the instance of a game, which is where we store:

    - The bank account of the shop
        - cash account balance
        - loans taken account
        - all of the transactions of the business
    - The stock supplies of the shop
]]
local Object = require "lib.helpers.classic"
local Game = Object:extend()

function Game:new()
    self.bank_balance = 0
    self.stock = 0
    self.loan_amount = 0
end

-- Add 10 stock for $100
function Game:add_stock()
    local amount = 10
    local cost = 100
    self.bank_balance = self.bank_balance - cost
    self.stock = self.stock + amount
end

-- Sell 1 stock for $20
function Game:sell()
    local quantity = 1
    local price = 20
    self.bank_balance = self.bank_balance + (price * quantity)
    self.stock = self.stock - quantity
end

function Game:get_loan()
    local amount = 1000
    self.bank_balance = self.bank_balance + amount
    self.loan_amount = self.loan_amount + amount
end

function Game:repay_loan()
    local amount = 100
    self.bank_balance = self.bank_balance - amount
    self.loan_amount = self.loan_amount - amount
end

function Game:stats()
    print("Bank Balance\t", self.bank_balance)
    print("Loan Amount\t", self.loan_amount)
    print("Stock\t\t", self.stock)
end

return Game
