local function spilledDamage()
    Notify.Spilled()
    local playerPed = cache.ped

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
        lib.timer(Config.ExplosionTimer or 4000, function()
            TriggerServerEvent('wz-methlab:server:explosion', labCoords)
        end, true)
    else
        spilledDamage()
    end
end



RegisterNetEvent('wz-methlab:client:StartMethProduction', function()
    -- Task 1: Distillation (Only causes spills)
    if not Skillcheck.StartFirst() then
        return spilledDamage()
    end
    Wait(500)

    -- Task 2: Neutralization (Can explode)
    if not Skillcheck.StartSecond() then
        return handleCriticalFailure()
    end
    Wait(500)

    -- Task 3: Crystallization (Can explode)
    if not Skillcheck.StartThird() then
        return handleCriticalFailure()
    end
    Wait(Config.ExplosionTimer)
    -- Final Success Handshake
    TriggerServerEvent('wz-methlab:server:cookSuccess')
end)



RegisterNetEvent('wz-methlab:client:syncExplosion', function(coords)
    AddExplosion(coords.x, coords.y, coords.z, 7, 1.0, true, false, 1.0)
end)