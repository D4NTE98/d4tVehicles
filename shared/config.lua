Config = {}

Config.Command = 'garage'
Config.Keybind = 'F6'
Config.DrawDistance = 25.0
Config.InteractDistance = 2.2

Config.Marker = {
    type = 36,
    scale = vector3(0.7, 0.7, 0.7),
    color = { r = 80, g = 140, b = 255, a = 180 }
}

Config.Vehicle = {
    defaultFuel = 100.0,
    defaultEngine = 1000.0,
    defaultBody = 1000.0,
    platePrefix = 'D4T',
    lockDistance = 12.0,
    saveInterval = 30000,
    mileageTick = 10000,
    fuelTick = 10000
}

Config.Impound = {
    fee = 500,
    enabled = true
}

Config.Keys = {
    enabled = true,
    shareDistance = 3.0
}

Config.Tables = {
    vehicles = 'd4t_vehicles',
    keys = 'd4t_vehicle_keys',
    history = 'd4t_vehicle_history'
}
