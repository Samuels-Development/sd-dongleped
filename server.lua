local QBCore = exports["qb-core"]:GetCoreObject()

local data = {
    ["jeweler"] = "Available",
    ["mazebank"] = "Available",
    ["greatocean"] = "Available",
    ["harmony"] = "Available",
    ["paleto"] = "Available",
    ["uppervault"] = "Available"
}
local items = {
    {
        ["name"] = "electronickit",
        ["price"] = 100
    },
    {
        ["name"] = "gatecrack",
        ["price"] = 250
    },
    {
        ["name"] = "thermite",
        ["price"] = 500
    },
    {
        ["name"] = "trojan_usb",
        ["price"] = 500
    },
    {
        ["name"] = "drill",
        ["price"] = 100
    }
}

QBCore.Functions.CreateCallback(
    "sd-check:activity",
    function(source, cb)
        cb(data)
    end
)

RegisterServerEvent(
    "server-update",
    function(gelendata, textdata)
        data[gelendata] = textdata
    end
)

RegisterServerEvent(
    "itemverserverside",
    function(itemname)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local Crypto = xPlayer.PlayerData.money.crypto

        item_data = items[itemname]
        item_price = item_data.price
        if Crypto >= item_price then
            xPlayer.Functions.RemoveMoney("crypto", item_price)
            xPlayer.Functions.AddItem(itemname, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        else
            TriggerClientEvent("QBCore:Notify", source, "You don't have " .. item_price .. " cryptos", "error")
        end

        -- if itemname == "electronickit" then
        --     if Crypto >= 100 then
        --         xPlayer.Functions.RemoveMoney("crypto", 100)
        --         xPlayer.Functions.AddItem(itemname, 1)
        --         TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        --     else
        --         TriggerClientEvent("QBCore:Notify", source, "You don't have 100 cryptos", "error")
        --     end
        -- elseif itemname == "gatecrack" then
        --     if Crypto >= 250 then
        --         xPlayer.Functions.RemoveMoney("crypto", 250)
        --         xPlayer.Functions.AddItem(itemname, 1)
        --         TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        --     else
        --         TriggerClientEvent("QBCore:Notify", source, "You don't have 250 cryptos", "error")
        --     end
        -- elseif itemname == "thermite" then
        --     if Crypto >= 500 then
        --         xPlayer.Functions.RemoveMoney("crypto", 500)
        --         xPlayer.Functions.AddItem(itemname, 1)
        --         TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        --     else
        --         TriggerClientEvent("QBCore:Notify", source, "You don't have 500 cryptos", "error")
        --     end
        -- elseif itemname == "trojan_usb" then
        --     if Crypto >= 500 then
        --         xPlayer.Functions.RemoveMoney("crypto", 500)
        --         xPlayer.Functions.AddItem(itemname, 1)
        --         TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        --     else
        --         TriggerClientEvent("QBCore:Notify", source, "You don't have 1500 cryptos", "error")
        --     end
        -- elseif itemname == "drill" then
        --     if Crypto >= 100 then
        --         xPlayer.Functions.RemoveMoney("crypto", 100)
        --         xPlayer.Functions.AddItem(itemname, 1)
        --         TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        --     else
        --         TriggerClientEvent("QBCore:Notify", source, "You don't have 100 cryptos", "error")
        --     end
        -- end
    end
)
