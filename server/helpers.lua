Helpers = {}
Helpers.server = {}


-- Checks if the player has all required ingredients in one go
function Helpers.server.hasIngredients(source)
    for key, item in pairs(Config.items) do
        if key ~= 'finalAmount' and item ~= Config.items.final then 
            local count = exports.ox_inventory:GetItemCount(source, item)
            if count < 1 then return false end
        end
    end
    return true
end

-- Deducts ingredients from the player's inventory
function Helpers.server.removeIngredients(source)
    for key, item in pairs(Config.items) do
        -- Apply the same filter here
        if key ~= 'finalAmount' and item ~= Config.items.final then
            exports.ox_inventory:RemoveItem(source, item, 1)
        end
    end
end