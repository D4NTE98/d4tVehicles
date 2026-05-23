function GetPlayerVehicles(source, garageType)
    local owner = PlayerIdentifier(source)

    return DB.Query(('SELECT * FROM %s WHERE owner = ? AND deleted = 0 ORDER BY id DESC'):format(Config.Tables.vehicles), {
        owner
    })
end

function GetVehicleByPlate(plate)
    return DB.Single(('SELECT * FROM %s WHERE plate = ? AND deleted = 0 LIMIT 1'):format(Config.Tables.vehicles), {
        plate
    })
end

function CreateOwnedVehicle(source, model, garage)
    local owner = PlayerIdentifier(source)
    local plate = D4TVehicles.Plate()

    local id = DB.Insert(('INSERT INTO %s (owner, plate, model, garage, state, fuel, engine, body, mileage, mods, damage, position, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())'):format(Config.Tables.vehicles), {
        owner,
        plate,
        model,
        garage or 'legion',
        'stored',
        Config.Vehicle.defaultFuel,
        Config.Vehicle.defaultEngine,
        Config.Vehicle.defaultBody,
        0,
        D4TVehicles.Json({}),
        D4TVehicles.Json({}),
        D4TVehicles.Json({})
    })

    GiveVehicleKey(source, plate, 'owner')

    return id, plate
end

function UpdateVehicleState(plate, state, garage)
    DB.Execute(('UPDATE %s SET state = ?, garage = ?, updated_at = NOW() WHERE plate = ?'):format(Config.Tables.vehicles), {
        state,
        garage,
        plate
    })
end

function SaveVehicleData(plate, data)
    DB.Execute(('UPDATE %s SET fuel = ?, engine = ?, body = ?, mileage = ?, mods = ?, damage = ?, position = ?, updated_at = NOW() WHERE plate = ?'):format(Config.Tables.vehicles), {
        data.fuel or Config.Vehicle.defaultFuel,
        data.engine or Config.Vehicle.defaultEngine,
        data.body or Config.Vehicle.defaultBody,
        data.mileage or 0,
        D4TVehicles.Json(data.mods or {}),
        D4TVehicles.Json(data.damage or {}),
        D4TVehicles.Json(data.position or {}),
        plate
    })
end
