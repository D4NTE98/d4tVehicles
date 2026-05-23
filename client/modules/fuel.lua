CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            local fuel = GetVehicleFuelLevel(vehicle)
            local speed = GetEntitySpeed(vehicle)

            if speed > 1.0 then
                fuel = fuel - 0.08

                if fuel < 0.0 then
                    fuel = 0.0
                end

                SetVehicleFuelLevel(vehicle, fuel)

                if fuel <= 0.0 then
                    SetVehicleEngineOn(vehicle, false, true, true)
                end
            end
        end

        Wait(Config.Vehicle.fuelTick)
    end
end)
