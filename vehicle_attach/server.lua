RegisterNetEvent("vehicle:syncAttach")
AddEventHandler("vehicle:syncAttach", function(childNetId, parentNetId, offset, rot)
    TriggerClientEvent("vehicle:attach", -1, childNetId, parentNetId, offset, rot)
end)

RegisterNetEvent("vehicle:syncDetach")
AddEventHandler("vehicle:syncDetach", function(childNetId)
    TriggerClientEvent("vehicle:detach", -1, childNetId)
end)
