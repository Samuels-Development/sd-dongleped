local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent('sd-dongle:server:buyshit', function(ped)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not src or not Player or not ped then return end
    local cash = Player.PlayerData.money[Config.Shop[ped].type]

    if cash >= Config.Shop[ped].price then
        Player.Functions.RemoveMoney(Config.Shop[ped].type, Config.Shop[ped].price)
        Player.Functions.AddItem(Config.Shop[ped].item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Shop[ped].item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough '..Config.Shop[ped].type, 'error')
    end
end)

QBCore.Functions.CreateCallback('sd-dongleped:server:getCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)
