local DongleCoords = nil
local locale = SD.Locale.T

local BuyStuff = function(data)
    local src = source
    local Player = SD.GetPlayer(src)
    if not src or not Player or not data then return end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    local distance = #(playerCoords - DongleCoords)
    if distance <= 5.0 then
        local hasMoney = SD.Money.GetPlayerAccountFunds(src, Config.Shop[data].type)
        if hasMoney >= Config.Shop[data].price then
            SD.Money.RemoveMoney(src, Config.Shop[data].type, Config.Shop[data].price)
            SD.Inventory.AddItem(src, Config.Shop[data].item, 1)
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.purchase_successful'), 'success')
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.not_enough_money', {currency = Config.Shop[data].type}), 'error')
        end
    else
        print(locale('notifications.unauthorized_distance_attempt', {id = src, item_type = Config.Shop[data].type, distance = distance}))
        if src then DropPlayer(src) end  -- Drop player if trying to exploit distance
    end
end

RegisterNetEvent('sd-dongle:server:buyStuff', function(data)
    BuyStuff(data)
end)

-- Event to set the location when resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        GlobalState.DonglePedLocation = Config.DonglePedLocation[math.random(#Config.DonglePedLocation)]
        if GlobalState.DonglePedLocation then DongleCoords = SD.Vector.ToVector3(GlobalState.DonglePedLocation) end
    end
end)

-- Callback to count the number of cops
SD.Callback.Register('sd-dongle:server:getCops', function(source)
    local players = GetPlayers()
    local amount = 0
    for i=1, #players do
        local player = tonumber(players[i])
        if SD.HasGroup(player, { 'police' }) then
            amount = amount + 1
        end
    end
    return(amount)
end)

