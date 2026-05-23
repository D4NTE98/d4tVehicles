local function drawGarageMarker(coords)
    DrawMarker(
        Config.Marker.type,
        coords.x,
        coords.y,
        coords.z + 0.2,
        0.0,
        0.0,
        0.0,
        0.0,
        180.0,
        0.0,
        Config.Marker.scale.x,
        Config.Marker.scale.y,
        Config.Marker.scale.z,
        Config.Marker.color.r,
        Config.Marker.color.g,
        Config.Marker.color.b,
        Config.Marker.color.a,
        false,
        true,
        2,
        false,
        nil,
        nil,
        false
    )
end

CreateThread(function()
    while true do
        local sleep = 800
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for id, garage in pairs(Garages) do
            local distance = #(coords - garage.coords)

            if distance < Config.DrawDistance then
                sleep = 0
                drawGarageMarker(garage.coords)

                if distance <= Config.InteractDistance then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('Press ~INPUT_CONTEXT~ to open garage')
                    EndTextCommandDisplayHelp(0, false, true, -1)

                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('d4tVehicles:server:requestGarage', id)
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

RegisterCommand(Config.Command, function()
    local coords = GetEntityCoords(PlayerPedId())
    local closest = nil
    local closestDistance = 999.0

    for id, garage in pairs(Garages) do
        local distance = #(coords - garage.coords)

        if distance < closestDistance then
            closest = id
            closestDistance = distance
        end
    end

    if closest and closestDistance <= Config.DrawDistance then
        TriggerServerEvent('d4tVehicles:server:requestGarage', closest)
    end
end, false)

RegisterKeyMapping(Config.Command, 'Open d4tVehicles garage', 'keyboard', Config.Keybind)
