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

function checkstatus ()
    local context = {
        {
            id = 1,
            header = "Robberies Status",
            txt = "",
            params = {
                event = ""
            }
        },
    }
    QBCore.Functions.TriggerCallback('sd-check:activity', function(data)
        if data then
                table.insert(context, {
                    id = 2,
                    header = "Jeweler",
                    txt = data.jeweler,
                    params = {
                        event = "",
                        args = ""
                    },
                })
                table.insert(context, {
                    id = 4,
                    header = "Fleeca: Great Ocean",
                    txt = data.greatocean,
                    params = {
                        event = "",
                        args = ""
                    },
                })
                table.insert(context, {
                    id = 5,
                    header = "Fleeca: Harmony",
                    txt = data.harmony,
                    params = {
                        event = "",
                        args = ""
                    },
                })
                table.insert(context, {
                    id = 6,
                    header = "Paleto Bank",
                    txt = data.paleto,
                    params = {
                        event = "",
                        args = ""
                    },
                })
                table.insert(context, {
                    id = 7,
                    header = "Pacific Bank",
                    txt = data.uppervault,
                    params = {
                        event = "",
                        args = ""
                    },
                })
            end
    end)
    Wait(100)
    TriggerEvent('qb-menu:client:openMenu', context)
end

function buyitems ()
    local context1 = {
        {
            id = 1,
            header = "💥 Practice Makes Perfect! 💥",
            txt = "",
            params = {
                event = ""
            }
        },
    }
        table.insert(context1, {
            id = 2,
            header = "Electronic Kit (100SHUNG)",
            txt = "An electronic kit, specified for use on Fleeca Security Systems",
            params = {
            event = "itemverclientside",
            args = "electronickit"
        },
        })
        table.insert(context1, {
            id = 3,
            header = "Gate Cracker (250SHUNG)",
            txt = "Used to disable security locks on doors & gates",
            params = {
            event = "itemverclientside",
            args = "gatecrack"
        },
        })
        table.insert(context1, {
            id = 4,
            header = "Thermite (500SHUNG)",
            txt = "A low-yield thermite charge used to breach gates in the pacific bank",
            params = {
            event = "itemverclientside",
            args = "thermite"
        },
        })
        table.insert(context1, {
            id = 5,
            header = "Trojan USB (500SHUNG)",
            txt = "A USB infected with malware",
            params = {
            event = "itemverclientside",
            args = "trojan_usb"
        },
        })
        table.insert(context1, {
            id = 6,
            header = "Golden Tipped Drill (100SHUNG)",
            txt = "A specialized drill, used to crack highly armoured security deposit boxes",
            params = {
            event = "itemverclientside",
            args = "drill"
        },
        })
    Wait(100)
    TriggerEvent('qb-menu:client:openMenu', context1)
end

RegisterNetEvent("itemverclientside", function (itemname)
TriggerServerEvent("itemverserverside", itemname)
end)

AddEventHandler('chechkeventtarget', function(data)
    Wait(200)
    checkstatus()
end)

AddEventHandler('buyitemsseventtarget', function(data)
    Wait(200)
    buyitems()
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
                event = "chechkeventtarget",
                icon = "fas fa-clock",
                label = "Check Availability",
                job = "all",
            },
            {
                type = "client",
                event = "buyitemsseventtarget",
                icon = "fas fa-laptop-code",
                label = "Purchase Equıpment",
                job = "all",
            },
        },
        distance = 3.0 
    })

end)
