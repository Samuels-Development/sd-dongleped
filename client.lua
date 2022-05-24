local QBCore = exports['qb-core']:GetCoreObject()

-- Blip Creation

Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlip then
	   		info.blip = AddBlipForCoord(info.x, info.y, info.z)
	   		SetBlipSprite(info.blip, info.id)
	   		SetBlipDisplay(info.blip, 4)
	   		SetBlipScale(info.blip, 0.6)	
	   		SetBlipColour(info.blip, info.colour)
	   		SetBlipAsShortRange(info.blip, true)
	   		BeginTextCommandSetBlipName("STRING")
	   		AddTextComponentString('<FONT FACE="Sora">'.. info.title)
	   		EndTextCommandSetBlipName(info.blip)
	 	end
   	end	
end)

RegisterNetEvent('sd-dongle:activity', function(data)
    QBCore.Functions.TriggerCallback('sd-check:activity', function(data)
        if data then
            exports['qb-menu']:openMenu({
                {
                    
                    header = "💁 Robberies Status 💁",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
                {
                    
                    header = "Vangelico",
                    txt = data.jeweler,
                    params = {
                        event = ""
                    }
                },
                {
                    
                    header = "Paleto Bank",
                    txt = data.paleto,
                    params = {
                        event = ""
                    }
                },
                {
                    
                    header = "Pacific Bank",
                    txt = data.uppervault,
                    params = {
                        event = ""
                    }
                },
                {
                    
                    header = "Fleeca: Harmony",
                    txt = data.harmony,
                    params = {
                        event = ""
                    }
                },
                {
                    
                    header = "Fleeca: Great Ocean",
                    txt = data.greatocean,
                    params = {
                        event = ""
                    }
                },
                {
                    header = "Close (ESC)",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
            })
        end
    end)
end)

RegisterNetEvent('sd-dongle:buyitems', function(data)
            exports['qb-menu']:openMenu({
                {
                    
                    header = "💥 Practice Makes Perfect! 💥",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
                {
                    
                    header = "Electronic Kit (100SHUNG)",
                    txt = "An electronic kit, specified for use on Fleeca Security Systems",
                    params = {
                    event = "sd-dongle:client:itemcheck",
                    args = "electronickit"
                    }
                },
                {
                    
                    header = "Gate Cracker (250SHUNG)",
                    txt = "Used to disable security locks on doors & gates",
                    params = {
                    event = "sd-dongle:client:itemcheck",
                    args = "gatecrack"
                    }
                },
                {
                    
                    id = 4,
                    header = "Thermite (500SHUNG)",
                    txt = "A low-yield thermite charge used to breach gates in the pacific bank",
                    params = {
                    event = "sd-dongle:client:itemcheck",
                    args = "thermite"
                    }
                },
                {
                    
                    header = "Trojan USB (500SHUNG)",
                    txt = "A USB infected with malware",
                    params = {
                    event = "sd-dongle:client:itemcheck",
                    args = "trojan_usb"
                    }
                },
                {
                    
                    header = "Golden Tipped Drill (100SHUNG)",
                    txt = "A specialized drill, used to crack highly armoured security deposit boxes",
                    params = {
                    event = "sd-dongle:client:itemcheck",
                    args = "drill"
                    }
                },
                {
                    header = "Close (ESC)",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
            })
    end)

RegisterNetEvent("sd-dongle:client:itemcheck", function (itemname)
TriggerServerEvent("sd-dongle:server:itemcheck", itemname)
end)

-- Ped Creation

function SetupDongleBoss(coords)
    RequestModel(`cs_old_man2`)
    while not HasModelLoaded(`cs_old_man2`) do
    Wait(1)
    end
    donglenpc = CreatePed(2, `cs_old_man2`, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
    SetPedFleeAttributes(donglenpc, 0, 0)
    SetPedDiesWhenInjured(donglenpc, false)
    TaskStartScenarioInPlace(donglenpc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(donglenpc, true)
    SetBlockingOfNonTemporaryEvents(donglenpc, true)
    SetEntityInvincible(donglenpc, true)
    FreezeEntityPosition(donglenpc, true)
end

function CreatePeds()
    for i = 1, #Config.Peds do
        if Config.Peds[i].type == 'donglenpc' then
            SetupDongleBoss(Config.Peds[i].position, i)
        end
    end
end

CreateThread(function()
    CreatePeds()
end)


-- Target Exports

CreateThread(function()
    exports['qb-target']:AddTargetModel('cs_old_man2', {
        options = {
            { 
                type = "client",
                event = "sd-dongle:activity",
                icon = "fas fa-clock",
                label = "Check Availability",
                job = "all",
            },
            {
                type = "client",
                event = "sd-dongle:buyitems",
                icon = "fas fa-laptop-code",
                label = "Purchase Equıpment",
                job = "all",
            },
        },
        distance = 3.0 
    })

end)

