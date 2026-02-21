lib.callback.register('wz-methlab:server:canPlayerCook', function(source)
    if Helpers.server.hasIngredients(source) then
        Helpers.server.removeIngredients(source)
        
        -- 2. Tell the client to start the skill checks
        TriggerClientEvent('wz-methlab:client:StartMethProduction', source)
        
        return true
    end
    return false
end)




RegisterNetEvent('wz-methlab:server:explosion', function(targetCoords)
    local src = source
    local playerPed = GetPlayerPed(src)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- 1. Sync the explosion effect to everyone nearby
    -- Parameters: x, y, z, explosionType, damageScale, isAudible, isInvisible, cameraShake
    TriggerClientEvent('wz-methlab:client:syncExplosion', src, targetCoords)

    -- 2. Optional: "Brick" the vehicle so it can't be driven
    if vehicle ~= 0 then
        SetVehicleBodyHealth(vehicle, -4000)
    end
end)


RegisterNetEvent('wz-methlab:server:cookSuccess', function()
    local src = source
    local itemName = Config.items.final
    local amount = 1

    -- 1. Get the vehicle the player is currently in (or was just in)
    local playerPed = GetPlayerPed(src)
    local lastVeh = GetVehiclePedIsIn(playerPed, false)

    -- 2. Security Check: Is it a Journey?
    local rvHash = Config.vehicle_name

    if lastVeh ~= 0 and GetEntityModel(lastVeh) == rvHash then
        -- 3. Inventory Logic
        if exports.ox_inventory:CanCarryItem(src, itemName, amount) then
            print(string.format("Attempting to add %s to player %s", itemName, GetPlayerName(src)))
            exports.ox_inventory:AddItem(src, itemName, amount)
            TriggerClientEvent('ox_lib:notify', src, {title = 'Success', description = 'Batch secured.', type = 'success'})
        else
            exports.ox_inventory:CreateDropFromPlayer(src)
            TriggerClientEvent('ox_lib:notify', src, {title = 'Inventory Full', description = 'The meth fell on the floor!', type = 'warning'})
        end
    else
        -- 4. Anti-Cheat/Logging
        print(string.format("Warning: Player %s attempted to reward themselves without being in an RV!", GetPlayerName(src)))
    end
end)