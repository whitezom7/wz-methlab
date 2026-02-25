# WZ-METHLAB
A Optimized Meth producing FiveM script utilizing the Journey RV or any other vehicle of your choice!

## Features
Script uses 3 items that a server owner can choose how to implement into your server, make them easy or hard to get.

The radial menu option only appears when the player is inside the configured vehicle.

Players have 3 different skill checks to complete to get the final meth item, if they fail the first check they get slight damage, the other two checks can cause the same damage or a configured percentage check to make the RV blow up.

### Dependices
1. ox_inventory
2. ox_lib

## Installation
1. Put wz-methlab into your server resource folder
2. Add ensure wz-methlab to your server.cfg file
3. Add the images provided to ox_inventory/web/images
4. Add the inventory items data to ox_inventory/data/items.lua
5. Start your server


```lua
    ['meth_precursor'] = {
        label = 'Chemical Precursor',
        weight = 500,
        stack = true,
        close = true,
        description = 'A base chemical used in the synthesis of pharmaceutical products.',
        client = {
            image = 'meth_precursor.png'
        }
    },
    ['meth_reagent'] = {
        label = 'Reactive Catalyst',
        weight = 200,
        stack = true,
        close = true,
        description = 'A highly reactive substance required to trigger a chemical transformation.',
        client = {
            image = 'meth_reagent.png'
        }
    },
    ['meth_solvent'] = {
        label = 'Industrial Solvent',
        weight = 1000,
        stack = true,
        close = true,
        description = 'Used for dissolving and purifying chemical compounds.',
        client = {
            image = 'meth_solvent.png'
        }
    },
```

## Config file
```lua
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
```