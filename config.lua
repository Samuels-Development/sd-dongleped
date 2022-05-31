Config = {}

-- Blip Creation

Config.UseBlip = false

Config.BlipLocation = {
    {title="Shady Dealer", colour=37, id=47, x = -462.73, y = -66.37, z = 44.90},
} 

-- Ped Spawns

Config.Peds = {
    {
        type = 'donglenpc',
        position = vector4(-462.795, -66.5747, 44.511, 10.3)
    },
}

-- Menu Contents

Config.RobberyList = {
    [1] = {
        bank = true,
        Header = "Fleeca Banks",
        icon = "fa-solid fa-building-columns",
        minCops = 4,
    },
    [2] = {
        bank = true,
        Header = "Paleto Bank",
        icon = "fa-solid fa-building-columns",
        minCops = 4,
    },
    [3] = {
        bank = true,
        Header = "Pacific Bank",
        icon = "fa-solid fa-building-columns",
        minCops = 4,
    },
}

Config.Shop = {
    [1] = {
        item = "electronickit",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [2] = {
        item = "gatecrack",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [3] = {
        item = "thermite",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [4] = {
        item = "trojan_usb",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [5] = {
        item = "drill",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    }
}
