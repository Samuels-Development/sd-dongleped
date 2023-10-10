local SD = exports['sd_lib']:getLib()

RegisterNetEvent('sd-dongle:server:buyStuff', function(data)
    print(data, Config.Shop[data])
    local src = source
    local Player = SD.GetPlayer(src)
    if not src or not Player or not data then return end
    local hasMoney = SD.GetPlayerAccountFunds(src, Config.Shop[data].type)

    if hasMoney >= Config.Shop[data].price then
        SD.RemoveMoney(src, Config.Shop[data].type, Config.Shop[data].price)
        SD.AddItem(src, Config.Shop[data].item, 1)
    else
        TriggerClientEvent('sd_bridge:notification', src, 'Not enough '..Config.Shop[data].type, 'error')
    end
end)

-- Event to set the location when resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        GlobalState.DonglePedLocation = Config.DonglePedLocation[math.random(#Config.DonglePedLocation)]
    end
end)

-- Callback to count the number of cops
SD.RegisterCallback('sd-dongleped:server:getCops', function(source, cb)
    local players = GetPlayers()
    local amount = 0
    for i=1, #players do
        local player = tonumber(players[i])
        if SD.HasGroup(player, SD.PoliceJobs) then
            amount = amount + 1
        end
    end
    cb(amount)
end)

