local SD = exports['sd_lib']:getLib()

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
        AddTextComponentSubstringPlayerName(Config.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Create Ped
function CreatePedAtCoords(pedModel, coords)
    if type(pedModel) == "string" then pedModel = GetHashKey(pedModel) end
	SD.utils.LoadModel(pedModel)
    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z, coords.w, false, false)
    FreezeEntityPosition(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)

	SD.target.AddTargetEntity(ped, {
        options = {
            { 
                event = "sd-dongle:activity",
                icon = "fas fa-clock",
                label = "Check Availability",
            },
            {
                event = "sd-dongle:buyitems",
                icon = "fas fa-laptop-code",
                label = "Purchase Equıpment",
            },
        },
        distance = 3.0 
    })

	AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
            DeleteEntity(ped)
        end
    end)
	
    return ped
end

CreateThread(function()
    while not GlobalState.DonglePedLocation do Wait(0) end
    local ped = CreatePedAtCoords(Config.DonglePedModel, GlobalState.DonglePedLocation)
end)

RegisterNetEvent('sd-dongle:activity', function()
    SD.ServerCallback("sd-dongleped:server:getCops", function(enoughCops)
        local header = {
            {
                icon = "fa-solid fa-circle-info",
                header = "Available Robberies",
                params = {
                    event = "",
                }
            }
        }
        for k, v in pairs(Config.RobberyList) do
            if enoughCops >= v.minCops then
                header[#header+1] = {
                    header = v.Header,
                    txt = "✔️ Available",
                    icon = v.icon,
                    params = {
                        event = "",
                    }
                }
            else
                header[#header+1] = {
                    header = v.Header,
                    txt = "❌ Not Available",
                    icon = v.icon,
                    params = {
                        event = "",
                    }
                }
            end
        end
        header[#header+1] = {
            header = "Close (ESC)",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "",
            }
        }

        SD.menu.OpenMenuList(header)
    end)
end)

RegisterNetEvent('sd-dongle:buyitems', function(data)
    local header = {
        {
            icon = "fa-solid fa-circle-info",
            header = "💥 Practice Makes Perfect! 💥"
        }
    }
    
    for k, v in pairs(Config.Shop) do
        if v.label then 
            header[#header+1] = {
                header = v.label, 
                txt = "Price: "..v.price,
                icon = v.icon,
                params = {
                    event = "sd-dongle:client:buyStuff",
                    args = k
                }
            }
        end
    end

    header[#header+1] = {
        header = "Close (ESC)",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "",
        }
    }

    SD.menu.OpenMenuList(header)
end)

RegisterNetEvent('sd-dongle:client:buyStuff', function(data)
    TriggerServerEvent('sd-dongle:server:buyStuff', data)
end)
