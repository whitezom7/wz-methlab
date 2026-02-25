local function spilledDamage()
    local playerPed = cache.ped
    Notify.Spilled()

    ClearPedTasks(playerPed)


    local animDict = "timetable@gardener@smoking_joint"
    local animName = "idle_cough"

    -- 1. Reduce health slightly
    local currentHealth = GetEntityHealth(playerPed)
    SetEntityHealth(playerPed, currentHealth - 15)

    -- 2. Load and play the animation
    lib.requestAnimDict(animDict)
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 4000, 49, 0, false, false, false)
    AnimpostfxPlay('DrugsMichaelAliensFightIn', 4000, false)
    SetTimeout(10000, function()
        AnimpostfxStop('DrugsMichaelAliensFightIn')
    end)
end

local function handleCriticalFailure()
    local playerPed = cache.ped
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local labCoords = (vehicle ~= 0) and GetEntityCoords(vehicle) or GetEntityCoords(playerPed)

    if math.random() <= Config.explosion_chance then
        Notify.Explosion()
        SetVehicleEngineHealth(vehicle, -4000)
        SetTimeout(Config.ExplosionTimer or 4000, function()
            TriggerServerEvent('wz-methlab:server:explosion', labCoords)
        end)
    else
        spilledDamage()
    end
end



RegisterNetEvent('wz-methlab:client:StartMethProduction', function()
    -- Task 1: Distillation
    if not Skillcheck.StartFirst() then
        return spilledDamage()
    end
    if not lib.callback.await('wz-methlab:server:validateStep', false, 1) then return end
    Wait(500)

    -- Task 2: Neutralization
    if not Skillcheck.StartSecond() then
        return handleCriticalFailure()
    end
    if not lib.callback.await('wz-methlab:server:validateStep', false, 2) then return end
    Wait(500)

    -- Task 3: Crystallization
    if not Skillcheck.StartThird() then
        return handleCriticalFailure()
    end
    if not lib.callback.await('wz-methlab:server:validateStep', false, 3) then return end
    Wait(500)

    -- Final Success Handshake
    TriggerServerEvent('wz-methlab:server:cookSuccess')
end)



RegisterNetEvent('wz-methlab:client:syncExplosion', function(coords)
    AddExplosion(coords.x, coords.y, coords.z, 7, 1.0, true, false, 1.0)
end)