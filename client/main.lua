local locale = SD.Locale.T

-- Create Ped
local CreatePedAtCoords = function(pedModel, coords)
    local options = {
        {
            event = "sd-dongle:client:showRobberies",
            icon = "fas fa-clock",
            label = locale('target.check_availability'),
            canInteract = function()
                return true
            end
        },
        {
            event = "sd-dongle:client:buyItems",
            icon = "fas fa-laptop-code",
            label = locale('target.purchase_equipment'),
            canInteract = function()
                return true
            end
        }
    }

    local pedData = {
        model = pedModel,
        coords = coords,
        scenario = "WORLD_HUMAN_STAND_IMPATIENT",
        distance = 50,
        debug = false,
        targetOptions = {
            options = options,
            distance = 3.0
        }
    }

    -- Create the ped at the point using the SD.Ped module
    local point = SD.Ped.CreatePedAtPoint(pedData)
    return point
end

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(GlobalState.DonglePedLocation)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(locale('menu.practice_makes_perfect'))
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while not GlobalState.DonglePedLocation do Wait(0) end
    local ped = CreatePedAtCoords(Config.DonglePedModel, GlobalState.DonglePedLocation)
end)

local ShowRobberies = function()

    -- Define the function to create the menu options
    local createOptions = function(enoughCops)
        local options = {}
        for k, v in pairs(Config.RobberyList) do
            table.insert(options, {
                title = v.Header,
                description = v.description,
                icon = v.icon,
                disabled = enoughCops < v.minCops,
                onSelect = function()
                    TriggerEvent('sd-dongle:client:showRobberies')
                end
            })
        end
        table.insert(options, {
            title = locale('menu.close_esc'),
            icon = 'fa-solid fa-angle-left',
            onSelect = function()
                lib.hideContext()
            end
        })
        return options
    end

    -- Fetch data asynchronously and then show the context menu
    SD.Callback('sd-dongle:server:getCops', false, function(enoughCops)
        lib.registerContext({
            id = 'robberies_menu',
            title = locale('menu.available_robberies'),
            canClose = true,
            options = createOptions(enoughCops)
        })

        lib.showContext('robberies_menu')
    end)
end

RegisterNetEvent('sd-dongle:client:showRobberies', ShowRobberies)

local OpenShop = function()

    -- Define the function to create the menu options
    local createOptions = function()
        local options = {}
        for k, v in pairs(Config.Shop) do
            local randomPrice = v.price
            table.insert(options, {
                title = v.label,
                description = v.description .. "\n" .. locale('menu.price_label', {price = tostring(randomPrice)}),
                icon = v.icon,
                onSelect = function()
                    TriggerServerEvent('sd-dongle:server:buyStuff', k)
                end
            })
        end
        table.insert(options, {
            title = locale('menu.close_esc'),
            icon = 'fa-solid fa-angle-left',
            onSelect = function()
                lib.hideContext()
            end
        })
        return options
    end

    -- Register and show the context menu with options
    lib.registerContext({
        id = 'buy_items_menu',
        title = locale('menu.practice_makes_perfect'),
        canClose = true,
        options = createOptions()
    })

    lib.showContext('buy_items_menu')
end

RegisterNetEvent('sd-dongle:client:buyItems', OpenShop)

RegisterNetEvent('sd-dongle:client:buyStuff', function(data)
    TriggerServerEvent('sd-dongle:server:buyStuff', data)
end)