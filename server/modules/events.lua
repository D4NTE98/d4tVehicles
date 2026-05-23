RegisterNetEvent('d4tVehicles:server:requestGarage', function(garageId)
    local source = source
    local garage = Garages[garageId]

    if not garage then
        return
    end

    local vehicles = GetPlayerVehicles(source, garage.type)

    TriggerClientEvent('d4tVehicles:client:openGarage', source, {
        garage = garageId,
        garageData = garage,
        vehicles = vehicles
    })
end)

RegisterNetEvent('d4tVehicles:server:spawnVehicle', function(garageId, plate)
    local source = source
    local garage = Garages[garageId]
    local vehicle = GetVehicleByPlate(plate)

    if not garage or not vehicle then
        return
    end

    if not HasVehicleKey(source, plate) then
        return
    end

    if vehicle.state == 'out' then
        TriggerClientEvent('d4tVehicles:client:notify', source, 'Vehicle is already outside')
        return
    end

    if garage.type == 'impound' and Config.Impound.enabled then
        local core = exports.d4tCore:AccessCore()

        if core and core.Player and core.Player.RemoveMoney then
            core.Player.RemoveMoney(source, 'cash', Config.Impound.fee, 'impound_fee')
        end
    end

    UpdateVehicleState(plate, 'out', garageId)

    TriggerClientEvent('d4tVehicles:client:spawnVehicle', source, {
        garage = garage,
        vehicle = vehicle,
        mods = D4TVehicles.Decode(vehicle.mods),
        damage = D4TVehicles.Decode(vehicle.damage)
    })
end)

RegisterNetEvent('d4tVehicles:server:storeVehicle', function(garageId, plate, data)
    local source = source
    local garage = Garages[garageId]

    if not garage or not plate then
        return
    end

    if not HasVehicleKey(source, plate) then
        return
    end

    SaveVehicleData(plate, data or {})
    UpdateVehicleState(plate, 'stored', garageId)

    TriggerClientEvent('d4tVehicles:client:stored', source, plate)
end)

RegisterNetEvent('d4tVehicles:server:saveVehicle', function(plate, data)
    local source = source

    if not HasVehicleKey(source, plate) then
        return
    end

    SaveVehicleData(plate, data or {})
end)

RegisterNetEvent('d4tVehicles:server:toggleLock', function(plate)
    local source = source

    if not HasVehicleKey(source, plate) then
        return
    end

    TriggerClientEvent('d4tVehicles:client:toggleLock', source, plate)
end)

RegisterNetEvent('d4tVehicles:server:createTestVehicle', function(model)
    local source = source

    if not IsPlayerAceAllowed(source, 'd4tVehicles.admin') then
        return
    end

    local _, plate = CreateOwnedVehicle(source, model or 'sultan', 'legion')

    TriggerClientEvent('d4tVehicles:client:notify', source, ('Created vehicle %s'):format(plate))
end)
