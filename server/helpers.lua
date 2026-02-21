Helpers = {}
Helpers.server = {}


-- Checks if the player has all required ingredients in one go
function Helpers.server.hasIngredients(source)
    for _, item in pairs(Config.items) do
        if item ~= Config.items.final then -- Stops checks when it gets to the final item in the list
            local count = exports.ox_inventory:GetItemCount(source, item)
            if count < 1 then return false end
        end
    end
    return true
end

-- Deducts ingredients from the player's inventory
function Helpers.server.removeIngredients(source)
    for _, item in pairs(Config.items) do
        if item ~= Config.items.final then
            exports.ox_inventory:RemoveItem(source, item, 1)
        end
    end
end