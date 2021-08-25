-- Dependencies
local Object = require "lib.helpers.classic"
local BankAccount = require "lib.bank_account"

-- Business class
local Business = Object:extend()

function Business:new(name)
    -- Validations
    assert(type(name) == "string", "name must be provided")

    -- Attribute setters
    self.name = name
    self.bank_account = BankAccount()
end

return Business
