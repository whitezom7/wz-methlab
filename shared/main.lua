Config = {
    items = {
        precursor = 'meth_precursor',
        reagent = 'meth_reagent',
        solvent = 'meth_solvent',
        final = 'meth', -- default ox_inv meth item, can change to meth_baggy or any custom meth item you have
        finalAmount = 1 -- how much meth the player gets per successful cook
    },
    -- Gas Mask not implemented yet
    gasMaskRequired = false, -- if true, player needs to have a gas mask in inventory/on their playerPed to start the cook

    vehicle_name = `journey`,
    damageOnSpill = 15, -- does 15 damage when player fails the first skillcheck

    ExplosionTimer = 4000, -- Time in milliseconds
    explosion_chance = 0.2, -- 0.2 = 20% chance 






    -- Skill check for when making the meth, feel free to change the difficulty for each task as you see fit, choose from easy, medium, hard
    skillcheck = {
        first_task = {
            difficulty = {'easy', 'medium', 'easy'}, keys = {'w', 'a', 's', 'd'}
        },
        second_task = {
            difficulty = {'hard'}, keys = {'w', 'a', 's', 'd'}
        },
        third_task = {
            difficulty = {'medium', 'medium', 'medium'}, keys = {'w', 'a', 's', 'd'}
        }
    }
}