Notify = {}

function Notify.StartingCook()
    lib.notify({
        title = 'Lab Active',
        description = "Starting the meth cook...", 
        type = 'success'
    })
end

function Notify.MissingIngredients()
    lib.notify({
        title = 'Supplies Missing',
        description = "You don't have the required chemicals!", 
        type = 'error'
    })
end

function Notify.WrongVehicle()
    lib.notify({
        title = 'Equipment Error',
        description = "You need a specific mobile lab for this.", 
        type = 'info'
    })
end

function Notify.Success()
    lib.notify({
        title = 'Batch Complete',
        description = "The cook was successful! Product secured.", 
        type = 'success'
    })
end

function Notify.Explosion()
    lib.notify({
        title = 'CRITICAL FAILURE',
        description = "The pressure was too high! Get out now!", 
        type = 'error'
    })
end

function Notify.Spilled()
    lib.notify({
        title = 'Warning',
        description = "You spilled some of the batch on yourself. Ouch!",
        type = 'error'
    })
end