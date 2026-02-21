Helpers = {}

function Helpers.isPlayerInLab()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        local modelHash = GetEntityModel(vehicle)

        if modelHash == GetHashKey(Config.vehicle_name) then
            return true
        else
            lib.notify({description = 'You need a specific mobile lab for this.', type = 'info'})
            return false
        end
    end
    -- Explicitly return false if not in any vehicle
    lib.notify({description = 'You are not in a vehicle!', type = 'error'})
    return false
end


function Helpers.canCook()
    local canCook = lib.callback.await('wz-methlab:server:canPlayerCook')

    if canCook then
        Notify.StartingCook()
    else
        lib.notify({description = "You don't have the required chemicals!", type = 'info'})
    end
end

