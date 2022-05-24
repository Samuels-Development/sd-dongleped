local QBCore = exports["qb-core"]:GetCoreObject()

local data = {
    ["jeweler"] = "Available",
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
    "sd-dongle:server:itemcheck",
    function(itemname)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local Crypto = xPlayer.PlayerData.money.crypto

        item_data = nil
        for i = 1, #items do
            if items[i].name == itemname then
                item_data = items[i]
            end
        end
        item_price = item_data.price
        if Crypto >= item_price then
            xPlayer.Functions.RemoveMoney("crypto", item_price)
            xPlayer.Functions.AddItem(itemname, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemname], "add")
        else
            TriggerClientEvent("QBCore:Notify", source, "You don't have " .. item_price .. " Qbits", "error")
        end
    end
)
