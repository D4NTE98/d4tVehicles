local function applyVehicleData(vehicle, data)
    SetVehicleNumberPlateText(vehicle, data.vehicle.plate)
    SetVehicleFuelLevel(vehicle, tonumber(data.vehicle.fuel) or Config.Vehicle.defaultFuel)
    SetVehicleEngineHealth(vehicle, tonumber(data.vehicle.engine) or Config.Vehicle.defaultEngine)
    SetVehicleBodyHealth(vehicle, tonumber(data.vehicle.body) or Config.Vehicle.defaultBody)
end

RegisterNetEvent('d4tVehicles:client:spawnVehicle', function(data)
    local garage = data.garage
    local model = joaat(data.vehicle.model)

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(10)
    end

    local vehicle = CreateVehicle(model, garage.spawn.x, garage.spawn.y, garage.spawn.z, garage.spawn.w, true, false)

    applyVehicleData(vehicle, data)
    SetVehicleOnGroundProperly(vehicle)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

    VehicleClient.currentVehicle = vehicle
    CloseVehicleUI()
end)

RegisterNetEvent('d4tVehicles:client:stored', function(plate)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if vehicle ~= 0 and GetVehicleNumberPlateText(vehicle):gsub('%s+', '') == plate:gsub('%s+', '') then
        DeleteEntity(vehicle)
    end
end)

function CaptureVehicleData(vehicle)
    local coords = GetEntityCoords(vehicle)
    local heading = GetEntityHeading(vehicle)

    return {
        fuel = GetVehicleFuelLevel(vehicle),
        engine = GetVehicleEngineHealth(vehicle),
        body = GetVehicleBodyHealth(vehicle),
        mileage = VehicleClient.mileage[GetVehicleNumberPlateText(vehicle)] or 0,
        position = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
            w = heading
        },
        mods = {},
        damage = {}
    }
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            local plate = GetVehicleNumberPlateText(vehicle):gsub('%s+', '')
            local data = CaptureVehicleData(vehicle)

            TriggerServerEvent('d4tVehicles:server:saveVehicle', plate, data)
        end

        Wait(Config.Vehicle.saveInterval)
    end
end)
