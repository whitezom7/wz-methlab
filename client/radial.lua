lib.onCache('vehicle', function(value)
    if value then
        local modelHash = GetEntityModel(value)
        
        -- Check if the vehicle is the Journey
        if modelHash == GetHashKey(Config.vehicle_name) then
            lib.addRadialItem({
                id = 'cook_meth',
                icon = 'flask',
                label = 'Start Cooking',
                onSelect = function()
                    Helpers.canCook()
                end
            })
        end
    else
        -- Remove the item when player leaves the vehicle
        lib.removeRadialItem('cook_meth')
    end
end)