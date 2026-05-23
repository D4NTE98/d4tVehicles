RegisterCommand('vlock', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, Config.Vehicle.lockDistance, 0, 71)
    end

    if vehicle == 0 then
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle):gsub('%s+', '')

    TriggerServerEvent('d4tVehicles:server:toggleLock', plate)
end, false)

RegisterKeyMapping('vlock', 'Toggle vehicle lock', 'keyboard', 'L')

RegisterNetEvent('d4tVehicles:client:toggleLock', function(plate)
    local coords = GetEntityCoords(PlayerPedId())
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, Config.Vehicle.lockDistance, 0, 71)

    if vehicle == 0 then
        return
    end

    local vehiclePlate = GetVehicleNumberPlateText(vehicle):gsub('%s+', '')

    if vehiclePlate ~= plate:gsub('%s+', '') then
        return
    end

    local locked = GetVehicleDoorLockStatus(vehicle) ~= 1

    SetVehicleDoorsLocked(vehicle, locked and 1 or 2)
    SetVehicleLights(vehicle, 2)
    Wait(150)
    SetVehicleLights(vehicle, 0)
end)
