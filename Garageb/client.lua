local punto = {x = 216.25, y = -810.29, z = 30.72}
local spawn = {x = 233.75, y = -788.8, z = 30.61, h = 158.53}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(20, punto.x, punto.y, punto.z, - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0,6001,255,255,255, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(punto.x, punto.y, punto.z, GetEntityCoords(GetPlayerPed(-1))) < 1.5 then
            ESX.ShowHelpNotification("Pulsa `E´ para sacar un vehículo")
            if IsControlJustPressed(1, 38) then
                ESX.ShowNotification("El vehículo ha sido sacado")
                spawn_vehicle(spawn)
            end
        end
    end
end)

function spawn_vehicle(posicion)
    local spawn_car = CreateVehicle(vehicle, posicion.x, posicion.y, posicion.z, true, true)
    local car = "t20"

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, posicion.x, posicion.y, posicion.z, 158.53, true, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
end