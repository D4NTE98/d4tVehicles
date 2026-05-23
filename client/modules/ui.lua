function OpenVehicleUI(payload)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'open',
        payload = payload
    })
end

function CloseVehicleUI()
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'close'
    })
end

RegisterNUICallback('close', function(_, cb)
    CloseVehicleUI()
    cb({ ok = true })
end)

RegisterNUICallback('spawn', function(data, cb)
    TriggerServerEvent('d4tVehicles:server:spawnVehicle', data.garage, data.plate)
    cb({ ok = true })
end)

RegisterNUICallback('refresh', function(data, cb)
    TriggerServerEvent('d4tVehicles:server:requestGarage', data.garage)
    cb({ ok = true })
end)

RegisterNetEvent('d4tVehicles:client:openGarage', function(payload)
    VehicleClient.garage = payload.garage
    OpenVehicleUI(payload)
end)

RegisterNetEvent('d4tVehicles:client:notify', function(message)
    SendNUIMessage({
        action = 'notify',
        message = message
    })
end)
