RegisterCommand("attach", function(source, args)
    local targetModel = args[1]
    if not targetModel then
        print("Usage: /attach [model]")
        return
    end

    local playerPed = PlayerPedId()
    local inVeh = GetVehiclePedIsIn(playerPed, false)
    local playerPos = GetEntityCoords(playerPed)
    local attachVeh = 0

    if inVeh ~= 0 then
        attachVeh = inVeh
    else
        local vehicles = GetGamePool('CVehicle')
        for _, veh in pairs(vehicles) do
            local pos = GetEntityCoords(veh)
            if #(playerPos - pos) < 5.0 then
                attachVeh = veh
                break
            end
        end

        if attachVeh == 0 then
            print("No vehicle nearby to attach.")
            return
        end
    end

    local vehicles = GetGamePool('CVehicle')
    local closestVeh = nil
    local closestDistSq = 30.0 * 30.0

    for _, veh in pairs(vehicles) do
        if veh ~= attachVeh then
            local vehPos = GetEntityCoords(veh)
            local distSq = #(playerPos - vehPos)^2
            if distSq < closestDistSq then
                local model = GetEntityModel(veh)
                if GetDisplayNameFromVehicleModel(model):lower() == targetModel:lower() then
                    closestVeh = veh
                    closestDistSq = distSq
                end
            end
        end
    end

    if closestVeh then
        local offset = GetOffsetFromEntityGivenWorldCoords(closestVeh, GetEntityCoords(attachVeh))
        local rotOffset = GetEntityRotation(attachVeh, 2) - GetEntityRotation(closestVeh, 2)

        SetEntityCollision(attachVeh, false, false)
        AttachEntityToEntity(attachVeh, closestVeh, -1, offset.x, offset.y, offset.z,
            rotOffset.x, rotOffset.y, rotOffset.z, false, false, false, false, 2, true)

        print("Vehicle attached to " .. targetModel)

        CreateThread(function()
            Wait(500)
            SetEntityCollision(attachVeh, true, true)
            FreezeEntityPosition(attachVeh, false)
        end)
    else
        print("No vehicle with model '" .. targetModel .. "' found within 30 units.")
    end
end, false)

RegisterCommand("detach", function()
    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)

    if playerVeh ~= 0 and IsEntityAttached(playerVeh) then
        DetachEntity(playerVeh, true, true)
        print("Vehicle detached.")
        return
    end

    local playerPos = GetEntityCoords(playerPed)
    local vehicles = GetGamePool('CVehicle')

    for _, veh in pairs(vehicles) do
        if IsEntityAttached(veh) then
            local pos = GetEntityCoords(veh)
            if #(playerPos - pos) < 5.0 then
                DetachEntity(veh, true, true)
                TaskWarpPedIntoVehicle(playerPed, veh, -1)
                print("Detached nearby vehicle and entered it.")
                return
            end
        end
    end

    print("No attached vehicle nearby to detach.")
end, false)
