Config = {}

-- Blip Creation
Config.Blip = {
    Enable = false, -- Change to false to disable blip creation
    Sprite = 480, -- Sprite/Icon
    Display = 4,
    Scale = 0.6,
    Colour = 1,
    Name = "Mysterious Person", -- Name of the blip
}

-- Ped Spawns
Config.DonglePedModel = 'cs_old_man2' -- The model name of the boss ped.

Config.DonglePedLocation = { -- The locations where the boss can spawn.
    [1] = vector4(-64.23, 77.13, 70.62, 66.73),
   -- [2] = vector4(-274.91, 195.72, 85.6, 269.13),
   -- [3] = vector4(683.48, -789.34, 23.5, 0.13)
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
        label = "Electronic Kit",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [2] = {
        item = "gatecrack",
        label = "Gate Crack",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [3] = {
        item = "thermite",
        label = "Thermite",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [4] = {
        item = "trojan_usb",
        label = "Trojan USB",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    },
    [5] = {
        item = "drill",
        label = "Drill",
        price = 5450,
        type = "cash",
        icon = "fa-solid fa-laptop-code",
    }
}
