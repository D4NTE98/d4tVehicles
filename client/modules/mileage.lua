CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            local plate = GetVehicleNumberPlateText(vehicle):gsub('%s+', '')
            local speed = GetEntitySpeed(vehicle)

            VehicleClient.mileage[plate] = (VehicleClient.mileage[plate] or 0) + (speed * Config.Vehicle.mileageTick / 1000.0 / 1000.0)
        end

        Wait(Config.Vehicle.mileageTick)
    end
end)
