function HasVehicleKey(source, plate)
    if not Config.Keys.enabled then
        return true
    end

    local owner = PlayerIdentifier(source)

    local row = DB.Single(('SELECT id FROM %s WHERE identifier = ? AND plate = ? LIMIT 1'):format(Config.Tables.keys), {
        owner,
        plate
    })

    return row ~= nil
end

function GiveVehicleKey(source, plate, keyType)
    local identifier = PlayerIdentifier(source)

    local exists = DB.Single(('SELECT id FROM %s WHERE identifier = ? AND plate = ? LIMIT 1'):format(Config.Tables.keys), {
        identifier,
        plate
    })

    if exists then
        return true
    end

    DB.Insert(('INSERT INTO %s (identifier, plate, key_type, created_at) VALUES (?, ?, ?, NOW())'):format(Config.Tables.keys), {
        identifier,
        plate,
        keyType or 'shared'
    })

    return true
end

function RemoveVehicleKey(identifier, plate)
    DB.Execute(('DELETE FROM %s WHERE identifier = ? AND plate = ?'):format(Config.Tables.keys), {
        identifier,
        plate
    })
end

RegisterNetEvent('d4tVehicles:server:giveKey', function(target, plate)
    local source = source
    target = tonumber(target)

    if not target or not plate then
        return
    end

    if not HasVehicleKey(source, plate) then
        return
    end

    local sourcePed = GetPlayerPed(source)
    local targetPed = GetPlayerPed(target)

    if #(GetEntityCoords(sourcePed) - GetEntityCoords(targetPed)) > Config.Keys.shareDistance then
        return
    end

    GiveVehicleKey(target, plate, 'shared')

    TriggerClientEvent('d4tVehicles:client:notify', source, 'Vehicle key shared')
    TriggerClientEvent('d4tVehicles:client:notify', target, 'You received a vehicle key')
end)
